Class {
	#name : #ToListNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-List-node'
}

{ #category : #accessing }
ToListNodeHolder >> data [
	^ self infiniteElement dataSource data
]
