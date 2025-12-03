Class {
	#name : #ToTabFiniteListElement,
	#superclass : #ToCheckableFiniteListElement,
	#instVars : [
		'atStartSide'
	],
	#category : #'Toplo-Widget-TabPane-TabBar'
}

{ #category : #configuration }
ToTabFiniteListElement >> applyConfiguration [

	super applyConfiguration.
	self nodeContainersDo: [ :container |
		container node item requestConfiguration.
		container node requestNewSkin ].
	self requestLayout
]

{ #category : #accessing }
ToTabFiniteListElement >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabFiniteListElement >> atStartSide: aBoolean [

	atStartSide = aBoolean ifTrue: [ ^ self ].
	atStartSide := aBoolean.
	self requestConfiguration
]

{ #category : #'t - item list - accessing' }
ToTabFiniteListElement >> defaultNodeManagerClass [

	^ ToTabNodeManager
]

{ #category : #initialization }
ToTabFiniteListElement >> initialize [ 

	super initialize.
	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true.
	atStartSide := true
]

{ #category : #testing }
ToTabFiniteListElement >> isAtEndSide [ 

	^ self isAtStartSide not
]

{ #category : #testing }
ToTabFiniteListElement >> isAtStartSide [

	^ atStartSide
]

{ #category : #skin }
ToTabFiniteListElement >> newRawSkin [ 

	^ ToTabBarElementSkin new
]
