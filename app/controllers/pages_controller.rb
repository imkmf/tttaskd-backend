class PagesController < ApplicationController
  def root
    render text: 'ok'
  end

  def letsencrypt
    render text: "m7MObgxRL-JctHHKqYIpD_Vm1_AcTtrb_XCsuZkgacE.18axvS74ZtxI4xiWpoZQHuDhazxSf0xBjkHDWTpaTSo"
  end
end
