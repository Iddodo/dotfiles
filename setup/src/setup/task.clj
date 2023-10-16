(ns setup.task)

(defmacro do-top-ruler [title & body]
  `(do
     (println "------------------------------------")
     (println ~title)
     (println "------------------------------------")
     ~@body
     (println "------------------------------------")))

(defmacro do [title & body]
  `(do
     (println ~title)
     (println "------------------------------------")
     ~@body
     (println "------------------------------------")))
