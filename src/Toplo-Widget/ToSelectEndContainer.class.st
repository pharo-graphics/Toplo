Class {
	#name : #ToSelectEndContainer,
	#superclass : #ToTripletElement,
	#category : #'Toplo-Widget-Select'
}

{ #category : #accessing }
ToSelectEndContainer >> icon [

	^ self middleElement
]

{ #category : #accessing }
ToSelectEndContainer >> icon: anElement [

	self middleElement: anElement.
	anElement ifNotNil: [ anElement id: #icon ]
]

{ #category : #skin }
ToSelectEndContainer >> newRawSkin [ 

	^ ToSelectEndContainerSkin new
]
