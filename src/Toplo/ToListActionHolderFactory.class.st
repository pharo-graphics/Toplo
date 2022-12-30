Class {
	#name : #ToListActionHolderFactory,
	#superclass : #ToInfiniteHolderFactory,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListActionHolderFactory >> action [

	^ action
]

{ #category : #accessing }
ToListActionHolderFactory >> action: aValuable [

	action := aValuable
]

{ #category : #initialization }
ToListActionHolderFactory >> initialize [ 

	super initialize.
	action := [ :infinite | ToListNodeHolder new  ]
]

{ #category : #'holder creating' }
ToListActionHolderFactory >> value: anInfinite [

	^ self action value: anInfinite
]
