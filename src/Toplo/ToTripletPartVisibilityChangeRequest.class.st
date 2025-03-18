Class {
	#name : #ToTripletPartVisibilityChangeRequest,
	#superclass : #BlEvent,
	#instVars : [
		'hideStart',
		'hideMiddle',
		'hideEnd'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToTripletPartVisibilityChangeRequest >> hideEnd [

	^ hideEnd
]

{ #category : #accessing }
ToTripletPartVisibilityChangeRequest >> hideEnd: aBoolean [

	hideEnd := aBoolean
]

{ #category : #accessing }
ToTripletPartVisibilityChangeRequest >> hideMiddle [

	^ hideMiddle
]

{ #category : #accessing }
ToTripletPartVisibilityChangeRequest >> hideMiddle: aBoolean [

	hideMiddle := aBoolean
]

{ #category : #accessing }
ToTripletPartVisibilityChangeRequest >> hideStart [

	^ hideStart
]

{ #category : #accessing }
ToTripletPartVisibilityChangeRequest >> hideStart: aBoolean [

	hideStart := aBoolean
]

{ #category : #initialization }
ToTripletPartVisibilityChangeRequest >> initialize [ 

	super initialize.
	hideStart := false.
	hideMiddle := false.
	hideEnd := false
]

{ #category : #sending }
ToTripletPartVisibilityChangeRequest >> sendTo: anObject [

	anObject tripletPartVisibilityChangeRequest: self
]
