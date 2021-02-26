require_relative '../spec_helper'

class UserRole

  attr_accessor :name, :description, :perms

  def initialize(name, description, deployment, perms = nil)
    @name = name
    @description = description
    record_types = if deployment == Deployment::CORE
                     CoreRecordTypes
                   else
                     sub_klasses = ObjectSpace.each_object(Class).select { |klass| klass < CoreRecordTypes }
                     sub_klasses.find { |p| p::DEPLOYMENT == deployment }
                   end
    obj = record_types::OBJECTS.map &:name
    auth = record_types::AUTHORITIES.map &:name
    proc = record_types::PROCEDURES.map &:name
    util = record_types::UTIL_RESOURCES.map &:name
    sec = record_types::SECURITY_RES.map &:name
    types = obj + auth + proc + util + sec
    @perms = Hash[types.collect { |type| [type, nil] }]
    update_perms perms if perms
  end

  def update_perms(perms)
    @perms.deep_merge! perms
  end

end
