# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

book = Book.find_or_create_by!(title: 'On the Origin of Species',
                               author: 'Charles Darwin',
                               path: Rails.root.join('public/pg1228.txt').to_s)

book.chapters.find_or_create_by!(number: 0,
                                 title: 'INTRODUCTION',
                                 start_line: 315,
                                 end_line: 477)

book.chapters.find_or_create_by!(number: 1,
                                 title: 'VARIATION UNDER DOMESTICATION',
                                 start_line: 485,
                                 end_line: 1584)

book.chapters.find_or_create_by!(number: 2,
                                 title: 'VARIATION UNDER NATURE',
                                 start_line: 1592,
                                 end_line: 2059)

book.chapters.find_or_create_by!(number: 3,
                                 title: 'STRUGGLE FOR EXISTENCE',
                                 start_line: 2067,
                                 end_line: 2631)

book.chapters.find_or_create_by!(number: 4,
                                 title: 'NATURAL SELECTION',
                                 start_line: 2639,
                                 end_line: 4135)

book.chapters.find_or_create_by!(number: 5,
                                 title: 'LAWS OF VARIATION',
                                 start_line: 4143,
                                 end_line: 5285)

book.chapters.find_or_create_by!(number: 6,
                                 title: 'DIFFICULTIES ON THEORY',
                                 start_line: 5293,
                                 end_line: 6365)

book.chapters.find_or_create_by!(number: 7,
                                 title: 'INSTINCT',
                                 start_line: 6373,
                                 end_line: 7467)

book.chapters.find_or_create_by!(number: 8,
                                 title: 'HYBRIDISM',
                                 start_line: 7475,
                                 end_line: 8456)

book.chapters.find_or_create_by!(number: 9,
                                 title: 'ON THE IMPERFECTION OF THE GEOLOGICAL RECORD',
                                 start_line: 8464,
                                 end_line: 9404)

book.chapters.find_or_create_by!(number: 10,
                                 title: 'ON THE GEOLOGICAL SUCCESSION OF ORGANIC BEINGS',
                                 start_line: 9412,
                                 end_line: 10_407)

book.chapters.find_or_create_by!(number: 11,
                                 title: 'GEOGRAPHICAL DISTRIBUTION',
                                 start_line: 10_415,
                                 end_line: 11_486)

book.chapters.find_or_create_by!(number: 12,
                                 title: 'GEOGRAPHICAL DISTRIBUTION—_continued_',
                                 start_line: 11_494,
                                 end_line: 12_296)

book.chapters.find_or_create_by!(number: 13,
                                 title: 'MUTUAL AFFINITIES OF ORGANIC BEINGS: MORPHOLOGY: EMBRYOLOGY: RUDIMENTARY ORGANS',
                                 start_line: 12_305,
                                 end_line: 13_685)

book.chapters.find_or_create_by!(number: 14,
                                 title: 'RECAPITULATION AND CONCLUSION',
                                 start_line: 13_693,
                                 end_line: 14_613)

book.import! { print '.' }
puts