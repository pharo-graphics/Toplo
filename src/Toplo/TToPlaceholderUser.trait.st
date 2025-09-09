Trait {
	#name : #TToPlaceholderUser,
	#category : #'Toplo-Core'
}

{ #category : #'t - place holder user' }
TToPlaceholderUser >> elementWithPlaceHolder [

	^ self
]

{ #category : #'t - place holder user' }
TToPlaceholderUser >> hidePlaceholder [

	self elementWithPlaceHolder hidePlaceholder
]

{ #category : #'t - place holder user' }
TToPlaceholderUser >> placeholderBuilder: aValuable [

	self elementWithPlaceHolder placeholderBuilder: aValuable
]

{ #category : #'t - place holder user' }
TToPlaceholderUser >> placeholderString: aString [

	self elementWithPlaceHolder placeholderString: aString
]

{ #category : #'t - place holder user' }
TToPlaceholderUser >> placeholderText: aText [

	self elementWithPlaceHolder placeholderText: aText
]

{ #category : #'t - place holder user' }
TToPlaceholderUser >> showPlaceholder [

	self elementWithPlaceHolder showPlaceholder
]
