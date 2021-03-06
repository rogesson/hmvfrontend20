require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/exams", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # exam. As you add validations to exam, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      result: '10%'
    }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response", :vcr do
      get exams_url
      expect(response).to be_successful

      exams = assigns(:exams)
      expect(exams).not_to be_nil

      expected = {
        id: 8,
        date: "2022-03-13T20:19:34",
        result: "10%"
      }

      expect(exams.last.attributes).to match(expected)
    end
  end

  describe "GET /show" do
    it "renders a successful response", :vcr do
      get exam_url(14)

      expect(response).to be_successful

      exam = assigns(:exam)
      patient = exam.patient
      exam_type = exam.exam_type

      expect(exam).not_to be_nil
      expect(patient).not_to be_nil
      expect(exam_type).not_to be_nil

      expect(exam.attributes).to match(
                                   {
                                     id: 12,
                                     result: '15%',
                                     date: '2022-03-25T00:00:00.257'
                                   }
                                 )
      expect(patient.attributes).to match(
                                      {
                                        cpf: "40734097867",
                                        email: "rogessonb@gmail.com",
                                        id: 2,
                                        name: "roger",
                                        password: "123123",
                                      }
                                    )

      expect(exam_type.attributes).to match(
                                        {
                                          id: 4,
                                          name: "Cardiol??gico",
                                        }
                                      )
    end
  end

  describe "GET /new" do
    it "renders a successful response", :vcr do
      get new_exam_url

      exam = assigns(:exam)
      expect(exam.attributes).to match(
                                   { id: nil, result: nil, date: nil }
                                 )
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response", :vcr do
      get edit_exam_url(5)
      expect(response).to be_successful
      exam = assigns(:exam)

      expect(exam.attributes).to match(
                                   { id: 5, result: '12%', date: '2022-03-13T20:19:34' }
                                 )
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new exam", :vcr do
        post exams_url, params: {
          exam: {
            result: "17%",
            date: '2022-03-31',
            patient: {
              id: 34,
            },
            exam_type: {
              id: 4
            }
          }
        }

        exam = assigns(:exam)
        expect(exam.attributes)
          .to match(
                {
                  id: 37,
                  result: '17%',
                  date: '2022-03-31T00:00:00.257'
                }
              )
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested exam", :vcr do
        new_exam_params = {
          exam: {
            id: 5,
            result: "17%",
            date: anything,
            patient: {
              id: 6
            },
            exam_type: {
              id: 4
            }
          }
        }

        patch exam_url(5), params: new_exam_params

        exam = assigns(:exam)
        expect(exam.attributes)
          .to match(
                {
                  id: 5,
                  result: '17%',
                  date: anything
                }
              )
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested exam", :vcr do
      delete exam_url(5)
      expect(response).to redirect_to(exams_url)
    end
  end
end
