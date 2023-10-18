require 'test_helper'

class SchedulingsControllerTest < ActionDispatch::IntegrationTest
  def setup
    Conference.destroy_all
  end

  def expected_api_response
    {"track_1"=>[{"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"09:00", "fim"=>"10:00"}, {"nome"=>"Trabalho remoto: prós e cons", "duracao"=>60, "inicio"=>"10:00", "fim"=>"11:00"}, {"nome"=>"A mágica do Rails: como ser mais produtivo", "duracao"=>60, "inicio"=>"11:00", "fim"=>"12:00"}, {"nome"=>"Almoço", "duracao"=>60, "inicio"=>"12:00", "fim"=>"13:00"}, {"nome"=>"Ruby on Rails: Por que devemos deixá-lo para trás", "duracao"=>60, "inicio"=>"13:00", "fim"=>"14:00"}, {"nome"=>"Manutenção de aplicações legadas em Ruby on Rails", "duracao"=>60, "inicio"=>"14:00", "fim"=>"15:00"}, {"nome"=>"Reinventando a roda em ASP clássico", "duracao"=>45, "inicio"=>"15:00", "fim"=>"15:45"}, {"nome"=>"Erros de Ruby oriundos de versões erradas de gems", "duracao"=>45, "inicio"=>"15:45", "fim"=>"16:30"}, {"nome"=>"Apresentando Lua para as massas", "duracao"=>30, "inicio"=>"16:30", "fim"=>"17:00"}, {"nome"=>"Evento de Networking", "inicio"=>"17:00"}], "track_2"=>[{"nome"=>"Erros comuns em Ruby", "duracao"=>45, "inicio"=>"09:00", "fim"=>"09:45"}, {"nome"=>"Desenvolvimento orientado a gambiarras", "duracao"=>45, "inicio"=>"09:45", "fim"=>"10:30"}, {"nome"=>"Programação em par", "duracao"=>45, "inicio"=>"10:30", "fim"=>"11:15"}, {"nome"=>"Clojure engoliu Scala: migrando minha aplicação", "duracao"=>45, "inicio"=>"11:15", "fim"=>"12:00"}, {"nome"=>"Almoço", "duracao"=>60, "inicio"=>"12:00", "fim"=>"13:00"}, {"nome"=>"Aplicações isomórficas: o futuro (que talvez nunca chegaremos)", "duracao"=>30, "inicio"=>"13:00", "fim"=>"13:30"}, {"nome"=>"Codifique menos, Escreva mais!", "duracao"=>30, "inicio"=>"13:30", "fim"=>"14:00"}, {"nome"=>"Ensinando programação nas grotas de Maceió", "duracao"=>30, "inicio"=>"14:00", "fim"=>"14:30"}, {"nome"=>"Ruby vs. Clojure para desenvolvimento backend", "duracao"=>30, "inicio"=>"14:30", "fim"=>"15:00"}, {"nome"=>"Um mundo sem StackOverflow", "duracao"=>30, "inicio"=>"15:00", "fim"=>"15:30"}, {"nome"=>"Otimizando CSS em aplicações Rails", "duracao"=>30, "inicio"=>"15:30", "fim"=>"16:00"}, {"nome"=>"Rails para usuários de Django", "duracao"=>5, "inicio"=>"16:00", "fim"=>"16:05"}, {"nome"=>"Evento de Networking", "inicio"=>"17:00"}]}
  end

  test 'should send file and get schedule response' do
    file = fixture_file_upload('conferences_example.txt', 'text/txt')
    
    assert_difference 'Conference.count', 19 do
      post '/schedulings', params: {file: file}, headers: { 'Content-Type': 'text/txt'}

      assert_equal expected_api_response, JSON.parse(response.body)
      assert_response :success
    end
  end
end