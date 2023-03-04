# OtpLab

A collection of modules to help learn OTP and Elixir. 

## Key-Value Store

The `OtpLab.KeyValueStore` module implements a simple key-value store. It is a GenServer that stores a map of key-value pairs. It has the following API:

* `start_link/0` - Starts the server
* `get/2` - Gets the value for a key
* `put/3` - Puts a key-value pair into the store
* `delete/2` - Deletes a key-value pair from the store