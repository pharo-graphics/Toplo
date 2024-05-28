Class {
	#name : #ToSelectIconContainer,
	#superclass : #ToTripletElement,
	#instVars : [
		'forFiltering'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectIconContainer >> forFiltering: aBoolean [

	forFiltering := aBoolean
]

{ #category : #accessing }
ToSelectIconContainer >> icon [

	^ self middleElement
]

{ #category : #accessing }
ToSelectIconContainer >> icon: anElement [

	self middleElement: anElement.
	anElement ifNotNil: [ anElement id: #icon ]
]

{ #category : #initialization }
ToSelectIconContainer >> initialize [

	super initialize.
	self id: #iconContainer
]

{ #category : #testing }
ToSelectIconContainer >> isSelectFiltrable [ 

	^ forFiltering
]

{ #category : #skin }
ToSelectIconContainer >> newRawSkin [ 

	^ ToSelectIconContainerSkin new
]
