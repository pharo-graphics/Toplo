Trait {
	#name : #TToCircularMenuListUser,
	#instVars : [
		'radius'
	],
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #'t - circular menu list user' }
TToCircularMenuListUser >> defaultRadius [

	^ 150
]

{ #category : #'t - circular menu list user' }
TToCircularMenuListUser >> radius [

	^ radius ifNil: [ radius := self defaultRadius ]
]

{ #category : #'t - circular menu list user' }
TToCircularMenuListUser >> radius: aNumber [

	radius := aNumber
]
