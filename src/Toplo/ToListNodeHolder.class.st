Class {
	#name : #ToListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListNodeHolder >> data [
	^ self infiniteElement dataSource data
]
