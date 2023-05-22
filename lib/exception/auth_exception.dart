class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'O Email já existe',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Muitas tentativas, tente novamente mais tarde',
    'EMAIL_NOT_FOUND': 'Email não encontrado',
    'INVALID_PASSWORD': 'O password inválida',
    'USER_DISABLED': 'Usuário desativado',
  };

  final String key;
  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro na autenticação';
  }
}
