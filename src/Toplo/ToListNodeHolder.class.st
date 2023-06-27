Class {
	#name : #ToListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListNodeHolder >> list [
	^ self infiniteElement dataSource list
]
