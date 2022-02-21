const insertMutation = """
    mutation InsertTask(\$description: String!, \$developer_id: String!, \$title: String!) {
  insert_tasks_one(object: {title: \$title, developer_id: \$developer_id, description: \$description}) {
    created_at
    description
    developer_id
    id
    isCompleted
    title
    updated_at
  }
}
    """;

const createMutation = """
    mutation InsertTask(\$description: String!, \$developer_id: String!, \$title: String!) {
  insert_tasks_one(object: {title: \$title, developer_id: \$developer_id, description: \$description}) {
    created_at
    description
    developer_id
    id
    isCompleted
    title
    updated_at
  }
}
""";

const deleteMutation = """
mutation DeleteTask(\$id: uuid = "") {
  delete_tasks_by_pk(id: \$id) {
    id
    developer_id
    description
    created_at
    isCompleted
    title
    updated_at
  }
}
""";

const updateMutation = """
    mutation UpdateTask(\$payload: tasks_set_input = {}, \$id: uuid!) {
  update_tasks_by_pk(pk_columns: {id: \$id}, _set: \$payload) {
    created_at
    description
    developer_id
    id
    isCompleted
    title
    updated_at
  }
}
""";
const getAllQuery = """
 query GetAllTasks(\$developer_id: String!) {
  tasks(where: {developer_id: {_eq: \$developer_id}}) {
    id
    developer_id
    description
    created_at
    isCompleted
    title
    updated_at
  }
}
 """;
