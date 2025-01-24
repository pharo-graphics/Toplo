Class {
	#name : #ToTreeNodeHolder,
	#superclass : #ToListNodeHolder,
	#instVars : [
		'expanded',
		'nodeHolder'
	],
	#category : #'Toplo-Widget-Tree'
}

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> expand [ 

	expanded := true.
]

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> fold [

	expanded := false.
]

{ #category : #initialization }
ToTreeNodeHolder >> initialize [ 

	super initialize.
	expanded := false.
]

{ #category : #accessing }
ToTreeNodeHolder >> nodeHolder [ 

	^ nodeHolder
]

{ #category : #accessing }
ToTreeNodeHolder >> nodeHolder: aTreeNodeHolder [ 

	nodeHolder := aTreeNodeHolder 
]
