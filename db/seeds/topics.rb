require 'faker'

puts "🌱 Creating topics"

topic_names = [ "Burn-out & épuisement professionnel", "Télétravail / hybride : isolement & charge mentale", "Reconversion & transitions pro", "Entrepreneurs, freelances & auto-entrepreneurs", "Managers & leadership bienveillant", "Fonction publique & agents territoriaux", "Enseignants et personnels éducatifs", "Carrière des femmes & plafond de verre", "Parentalité & charge mentale (y compris monoparentale)", "Aidants familiaux", "Familles recomposées / séparation / coparentalité", "Couple & sexualité après 40 ans", "Relations intergénérationnelles", "Gestion du stress & santé émotionnelle", "Sommeil & rythmes de vie", "Pleine conscience & méditation", "Nutrition & relation à l’alimentation", "Santé féminine (endométriose, PMA, ménopause)", "Activité physique & motivation", "Deuil & perte d’un proche", "Rupture, divorce, fin de PACS", "Retraite & fin de carrière", "Expatriation / retour en France", "Handicap acquis & adaptation", "Anxiété & dépression", "TDAH & troubles neuro-développementaux adultes", "Trauma & PTSD (attentats, violences)", "Maladies chroniques & douleur", "Addictions (alcool, cannabis, écrans)", "Troubles du spectre autistique (TSA)", "Soignants & aides-soignants", "Psychologues & travailleurs sociaux", "Bénévoles & secouristes" ]

topic_names.each do |name|
  Topic.create!(
    name:,
    category: Topic.categories.keys.sample,
  )
  puts "-- Created topic #{Topic.last.name}"
end
puts "✅ Created #{Topic.count} topics in total"
