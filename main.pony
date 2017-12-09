use "net"
use "net/ssl"

class iso MyTCPConnectionNotify is TCPConnectionNotify
  let _out: OutStream

  new create(out: OutStream) =>
    _out = out

  fun ref accepted(conn: TCPConnection ref) =>
    _out.print("MyTCPConnectionNotify.accepted:")

  fun ref connecting(conn: TCPConnection ref, count: U32) =>
    _out.print("MyTCPConnectionNotify.connecting: count=" + count.string())

  fun ref connected(conn: TCPConnection ref) =>
    _out.print("MyTCPConnectionNotify.connected: writing \"Hello\"")
    conn.write("Hello")

  fun ref connect_failed(conn: TCPConnection ref) =>
    _out.print("MyTCPConnectionNotify.connect_failed: FAILED")

  fun ref auth_failed(conn: TCPConnection ref) =>
    _out.print("MyTCPConnectionNotify.auth_failed:")

  fun ref sent(conn: TCPConnection ref, data: ByteSeq): ByteSeq =>
    _out.print("MyTCPConnectionNotify.sent: data=" + try data as String else "<data wasn't string>" end)
    data

  fun ref sentv(conn: TCPConnection ref, data: ByteSeqIter): ByteSeqIter =>
    conn.write("MyTCPConnectionNotify.sentv:")
    data

  fun ref received(
    conn: TCPConnection ref,
    data: Array[U8] iso,
    times: USize)
    : Bool
  =>
    _out.print("MyTCPConnectionNotify.received: data="
      + String.from_array(consume data))
    conn.close()
    true

  fun ref expect(conn: TCPConnection ref, qty: USize): USize =>
    _out.print("MyTCPConnectionNotify.expect: qty=" + qty.string())
    qty

  fun ref closed(conn: TCPConnection ref) =>
    _out.print("MyTCPConnectionNotify.closed:")

  fun ref throttled(conn: TCPConnection ref) =>
    _out.print("MyTCPConnectionNotify.throttled:")

  fun ref unthrottled(conn: TCPConnection ref) =>
    _out.print("MyTCPConnectionNotify.unthrottled:")


actor Main
  new create(env: Env) =>
    env.out.print("Main.create:+")
    try
      let ssl_ctx = SSLContext.>set_client_verify(false)
      env.out.print("Main.create: 1")
      let ssl_client = try ssl_ctx.client()? else env.out.print("no client ssl context"); error end
      env.out.print("Main.create: 2")
      let auth = try env.root as AmbientAuth else env.out.print("error root is not AmbientAuth"); error end
      env.out.print("Main.create: 3")
      let my_tcp_conn_notify: TCPConnectionNotify iso = recover MyTCPConnectionNotify(env.out) end
      env.out.print("Main.create: 4")
      let ssl_conn: TCPConnectionNotify iso =  recover SSLConnection(consume my_tcp_conn_notify, consume ssl_client) end
      env.out.print("Main.create: 5")
      TCPConnection(auth, consume ssl_conn, "", "8989")
    else
      env.out.print("error")
    end
    env.out.print("Main.create:-")
