require 'yaml'

# ConnectionManagement
class ConnectionManagement
  class << self
    def connect_to_db
      Sequel.connect(db_config)
    end

    def db
      YAML.load(db_config_file)
    end

    private

    def db_config_file
      File.open('./config/database.yml')
    end

    def db_config
      {
        adapter:         db['adapter'],
        host:            db['host'],
        user:            db['username'],
        password:        db['password'],
        database:        db['database'],
        max_connections: db['max_connections'],
        logger:          $logger
      }
    end
  end
end
