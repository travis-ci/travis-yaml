# describe Job do
#   let(:job) { FactoryGirl.build(:job) }
#
#   it 'normalizes deploy config' do
#     job.config = {
#       rvm: '2.2.2',
#       deploy: { foo: 'bar' }
#     }
#     expect(job.config[:deploy]).to be_nil
#     expect(job.config[:addons][:deploy]).to eq(foo: 'bar')
#   end
#
#   it 'drops addons if non-hash and deploy is present' do
#     job.config = {
#       rvm: '2.2.2',
#       addons: ['something'],
#       deploy: { baz: 'quux' }
#     }
#     expect(job.config[:addons]).to eq(deploy: { baz: 'quux' })
#   end
# end
