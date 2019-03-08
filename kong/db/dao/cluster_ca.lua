local ClusterCA = {}


function ClusterCA:cache_key(key, arg2, arg3, arg4, arg5)
  if type(key) == "string" then
    return self.super.cache_key(self, key, arg2, arg3, arg4, arg5)
  end

  return "cluster_cas:" .. tostring(key.key or "")
end


return ClusterCA
