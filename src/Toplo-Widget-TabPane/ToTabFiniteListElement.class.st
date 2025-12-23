Class {
	#name : #ToTabFiniteListElement,
	#superclass : #ToCheckableFiniteListElement,
	#instVars : [
		'atStartSide'
	],
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #configuration }
ToTabFiniteListElement >> applyConfiguration [

	super applyConfiguration.
	self nodeContainersDo: [ :container |
		container node item applyConfiguration.
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

{ #category : #'t - finite list element - fake container' }
ToTabFiniteListElement >> defaultFakeDataItem [

	^ ToTabItemElement new
		  labelText: 'X';
		  yourself
]

{ #category : #initialization }
ToTabFiniteListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeFactory: [ :holder | ToTabNode new ];
		  yourself
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

	^ ToTabFiniteListElementSkin new
]
