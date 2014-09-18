# Sample Maid rules file -- some ideas to get you started.
#
# To use, remove ".sample" from the filename, and modify as desired.  Test using:
#
#     maid clean -n
#
# **NOTE:** It's recommended you just use this as a template; if you run these rules on your machine without knowing what they do, you might run into unwanted results!
#
# Don't forget, it's just Ruby!  You can define custom methods and use them below:
#
#     def magic(*)
#       # ...
#     end
#
# If you come up with some cool tools of your own, please send me a pull request on GitHub!
#
# For more help on Maid:
#
# * Run `maid help`
# * Read the README, tutorial, and documentation at https://github.com/benjaminoakes/maid#maid
# * Ask me a question over email (hello@benjaminoakes.com) or Twitter (@benjaminoakes)

Maid.rules do

### Delete Application DMG files in Downloads
  rule 'Mac OS X applications in disk images' do
    trash(dir('~/Downloads/*.dmg'))
  end

### Delete Application .ZIP files in Downloads
  rule 'Mac OS X applications in zip files' do
    found = dir('~/Downloads/*.zip').select { |path|
      zipfile_contents(path).any? { |c| c.match(/\.app$/) }
    }

    trash(found)
  end

### File invoices to invoice folder
  rule 'Invoices in File folder' do
    move(dir('~/.mail/file/*INVOICE*'), '~/Documents/invoices_2014')
  end

### File estimates to estimate folder
  rule 'Estimates in Estimate folder' do
      move(dir('~/.mail/file/*Estimate*'), '~/Documents/Estimates')
    end

### File receipts to receipts folder
  rule 'Receipts in File folder' do
    move(dir('~/.mail/file/*receipt*'), '~/Documents/receipts_2014')
  end

### File proofs to Proofs folder
    rule 'Proofs in Proofs folder' do
      move(dir('~/.mail/file/*proof*'), '~/.mail/folders/Proofs')
    end

### File artwork to Artwork folder
    rule 'Artwork to artwork folder' do
        move(dir('~/.mail/file/*artwork*'), '~/.mail/folders/Artwork')
    end

### File letters to Documents folder
    rule 'Letters to Documents folder' do
        move(dir('~/.mail/file/*letter*'), '~/Documents/letters')
    end

### Move .PDF files from Downloads to Documents
  rule 'PDF files in Downloads' do
    move(dir('~/Downloads/*.pdf'), '~/Documents')
  end

### Move .AVI and .MP4 files from Downloads to my_movies
  rule 'Movie files in Downloads' do
    move(dir('~/Downloads/*.avi'), '/Volumes/Voloom/movies')
    move(dir('~/Downloads/*/*.avi'), '/Volumes/Voloom/movies')
    move(dir('~/Downloads/*.mp4'), '/Volumes/Voloom/movies')
    move(dir('~/Downloads/*/*.mp4'), '/Volumes/Voloom/movies')
    move(dir('~/Downloads/*.mkv'), '/Volumes/Voloom/movies')
    move(dir('~/Downloads/*/*.mkv'), '/Volumes/Voloom/movies')
  end

### Move screenshots to trash
  rule 'Screenshots in File' do
    move(dir('~/.mail/file/Screen*'), '~/.Trash')
  end

### Remove .deflate files from .w3m directory
  rule 'trash w3m deflate files' do
    move(dir('~/.w3m/*.deflate'), '~/.Trash')
  end

end
