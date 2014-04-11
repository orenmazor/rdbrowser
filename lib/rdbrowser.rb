require "./lib/rdbrowser/version"
require 'rdb'

module Rdbrowser
  class MyCallbacks
    include RDB::ReaderCallbacks
  end

  def self.list_databases(path_to_db)
    db_list = MyCallbacks.new
    db_list.instance_eval "def start_database(database); puts database; end"

    RDB::Reader.read_file(path_to_db, callbacks: db_list) 
  end

  def self.list_keys(path_to_db, filter = ".*")
    key_lister = MyCallbacks.new
    key_lister.instance_eval "KEY_SELECTOR = Regexp.compile(/#{filter}/)"
    key_lister.instance_eval "def accept_key?(state); state.database == 0 && KEY_SELECTOR.match(state.key); end"
    key_lister.instance_eval "def set(key, value, state); puts key; end"

    RDB::Reader.read_file(path_to_db, callbacks: key_lister)
  end

  def self.list_keys_with_ttl(path_to_db)
    key_lister = MyCallbacks.new
    key_lister.instance_eval "def accept_key?(state); state.key_expires?; end"
    key_lister.instance_eval "def set(key, value, state); puts key; end"
    RDB::Reader.read_file(path_to_db, callbacks: key_lister)
  end

  def self.list_keys_without_ttl(path_to_db)
    key_lister = MyCallbacks.new
    key_lister.instance_eval "def accept_key?(state); state.key_expires?; end"
    key_lister.instance_eval "def skip_object(key, state); puts key; end"
    RDB::Reader.read_file(path_to_db, callbacks: key_lister)
  end

  def self.dump(path_to_db)
    RDB::Reader.read_file(path_to_db, callbacks: RDB::DebugCallbacks.new)
  end
end
