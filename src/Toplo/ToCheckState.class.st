Class {
	#name : #ToCheckState,
	#superclass : #ToIntrinsicState,
	#instVars : [
		'checked'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToCheckState >> checked [

	^ checked
]

{ #category : #accessing }
ToCheckState >> checked: aBooleanOrIndeterminate [

	checked := aBooleanOrIndeterminate
]

{ #category : #accessing }
ToCheckState >> lookEventClass [

	^ self checked isSymbol
		  ifTrue: [ ToIndeterminateSkinEvent ]
		  ifFalse: [
			  self checked
				  ifTrue: [ ToCheckedSkinEvent ]
				  ifFalse: [ ToUncheckedSkinEvent ] ]
]
