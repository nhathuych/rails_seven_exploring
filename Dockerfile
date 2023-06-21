# các image như mysql, redis, ... có sẵn hết rồi nên chỉ cần pull về và chạy thôi
# còn image webapp thì phải tự build và cài đặt trong Dockerfile

# cài ruby bản slim gọn nhẹ(dc khuyến khích khi chạy ở môi trường development)
FROM ruby:3.2.1-slim

RUN apt-get update && apt-get install -y build-essential libmariadb-dev-compat libmariadb-dev

# option "-p" được sử dụng để tạo thư mục cha nếu nó chưa tồn tại
RUN mkdir -p /app
# thiết lập /app làm thư mục làm việc cho các lệnh tiếp theo trong Dockerfile
# ví dụ chạy "bundle install", "rails db:migrate", ... thì chạy trong thư mục này
WORKDIR /app

# copy các file bắt đầu bằng "Gemfile" (vì có dấu * ở cuối) từ máy host(local) vào image của web
# bao gồm cả Gemfile & Gemfile.lock
# COPY Gemfile Gemfile.lock .
COPY Gemfile* .

RUN bundle install

COPY . .
