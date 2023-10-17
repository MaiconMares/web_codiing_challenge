require 'test_helper'

class SchedulingHelperTest < ActionView::TestCase
  def extracted_conferences_response
    [{:name=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", :duration=>60},
      {:name=>"Reinventando a roda em ASP clássico", :duration=>45},
      {:name=>"Apresentando Lua para as massas", :duration=>30},
      {:name=>"Erros de Ruby oriundos de versões erradas de gems", :duration=>45},
      {:name=>"Erros comuns em Ruby", :duration=>45},
      {:name=>"Rails para usuários de Django", :duration=>5},
      {:name=>"Trabalho remoto: prós e cons", :duration=>60},
      {:name=>"Desenvolvimento orientado a gambiarras", :duration=>45},
      {:name=>"Aplicações isomórficas: o futuro (que talvez nunca chegaremos)", :duration=>30},
      {:name=>"Codifique menos, Escreva mais!", :duration=>30},
      {:name=>"Programação em par", :duration=>45},
      {:name=>"A mágica do Rails: como ser mais produtivo", :duration=>60},
      {:name=>"Ruby on Rails: Por que devemos deixá-lo para trás", :duration=>60},
      {:name=>"Clojure engoliu Scala: migrando minha aplicação", :duration=>45},
      {:name=>"Ensinando programação nas grotas de Maceió", :duration=>30},
      {:name=>"Ruby vs. Clojure para desenvolvimento backend", :duration=>30},
      {:name=>"Manutenção de aplicações legadas em Ruby on Rails", :duration=>60},
      {:name=>"Um mundo sem StackOverflow", :duration=>30},
      {:name=>"Otimizando CSS em aplicações Rails", :duration=>30}] 
  end

  def expected_schedule
    {"track_1"=>{"morning"=>[{"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"09:00", "fim"=>"10:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"10:00", "fim"=>"11:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"11:00", "fim"=>"12:00"}], "afternoon"=>[{"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"13:00", "fim"=>"14:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"14:00", "fim"=>"15:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"15:00", "fim"=>"16:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"16:00", "fim"=>"17:00"}]}}
  end

  def expected_sanitized_response
    {"track_1"=>[{"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"09:00", "fim"=>"10:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"10:00", "fim"=>"11:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"11:00", "fim"=>"12:00"}, {:nome=>"Almoço", :duracao=>60, :inicio=>"12:00", :fim=>"13:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"13:00", "fim"=>"14:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"14:00", "fim"=>"15:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"15:00", "fim"=>"16:00"}, {"nome"=>"Diminuindo tempo de execução de testes em aplicações Rails enterprise", "duracao"=>60, "inicio"=>"16:00", "fim"=>"17:00"}, {:nome=>"Evento de Networking", :inicio=>"17:00"}]}
  end
  
  test 'should read file and extract conferences and their durations' do
    file_path = Rails.root.join('test','fixtures','files','conferences_example.txt')

    expected_response = extracted_conferences_response

    response = extract_conferences_from_file(file_path)

    assert_equal expected_response, response
  end

  test 'should return best schedule for conferences' do
    conferences_to_schedule = [:one, :two, :three, :four, :five, :six, :seven, :eight, :nine]

    conferences = []
    conferences_to_schedule.each do |conf|
      conferences << conferences(:one)
    end

    response = schedule_conferences_optimal(conferences)

    assert_equal expected_schedule, response
  end

  test 'should sanitize schedule response' do
    response_to_sanitize = expected_schedule.with_indifferent_access

    sanitized_response = sanitize_response(response_to_sanitize)

    assert_equal expected_sanitized_response, sanitized_response
  end
end