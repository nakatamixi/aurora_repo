defmodule AuroraRepo do

  defmacro __using__(opts) do
    quote do
      use Ecto.Repo, unquote(opts)

      defoverridable [
        all: 2,
        stream: 2,
        get: 3,
        get!: 3,
        get_by: 3,
        get_by!: 3,
        one: 2,
        one!: 2,
        aggregate: 4,
        insert: 2,
        update: 2,
        insert_or_update: 2,
        delete: 2,
        insert!: 2,
        update!: 2,
        insert_or_update!: 2,
        delete!: 2,
        insert_all: 3,
        update_all: 3,
        delete_all: 2,
        transaction: 2
      ]

      defp process_mariaex_error(e) do
        # 1243 はER_UNKNOWN_STMT_HANDLE. zero-downtimeでバージョンアップされたmasterで、statement
        # がクリアされてしまった場合などを想定
        # 1290 はサーバ設定起因での statement 実行拒否系エラーコードで readonly 以外の場合も含まれるが
        # いわゆる環境エラーなので詳細は見ない
        if !__MODULE__.in_transaction? do
          case e.mariadb.code do
            1243 ->
              Logger.warn "error 1243: unknown statement handle. this may be caused by zero-downtime version upgrade."
            1290 ->
              Logger.warn "error 1290: this may cased during failover."
            other ->
              Logger.warn "error #{other}: unknown"
          end
          stop(__MODULE__)
        end
        stacktrace = System.stacktrace
        reraise e, stacktrace
      end

      def all(queryable, opts \\ []) do
        try do
          super(queryable, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end

      def stream(queryable, opts \\ []) do
        try do
          super(queryable, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end

      def get(queryable, id, opts \\ []) do
        try do
          super(queryable, id, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end

      def get!(queryable, id, opts \\ []) do
        try do
          super(queryable, id, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end

      def get_by(queryable, clauses, opts \\ []) do
        try do
          super(queryable, clauses, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end

      def get_by!(queryable, clauses, opts \\ []) do
        try do
          super(queryable, clauses, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end

      def one(queryable, opts \\ []) do
        try do
          super(queryable, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end

      def one!(queryable, opts \\ []) do
        try do
          super(queryable, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end

      def aggregate(queryable, aggregate, field, opts \\ []) do
        try do
          super(queryable, aggregate, field, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end

      def insert(struct, opts \\ []) do
        try do
          super(struct, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def update(struct, opts \\ []) do
        try do
          super(struct, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def insert_or_update(struct, opts \\ []) do
        try do
          super(struct, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def delete(struct, opts \\ []) do
        try do
          super(struct, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def insert!(struct, opts \\ []) do
        try do
          super(struct, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def update!(struct, opts \\ []) do
        try do
          super(struct, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def insert_or_update!(struct, opts \\ []) do
        try do
          super(struct, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def delete!(struct, opts \\ []) do
        try do
          super(struct, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def insert_all(schema, entries, opts \\ []) do
        try do
          super(schema, entries, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def update_all(schema, updates, opts \\ []) do
        try do
          super(schema, updates, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def delete_all(queryable, opts \\ []) do
        try do
          super(queryable, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
      def transaction(func_or_multi, opts \\ []) do
        try do
          super(func_or_multi, opts)
        rescue
          e in Mariaex.Error ->
            process_mariaex_error(e)
        end
      end
    end
  end
end
