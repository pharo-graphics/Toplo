Class {
	#name : #ToTabListElement,
	#superclass : #ToCheckableFiniteListElement,
	#instVars : [
		'atStartSide'
	],
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #configuration }
ToTabListElement >> applyConfiguration [

	super applyConfiguration.
	self nodeContainersDo: [ :container |
		container node item applyConfiguration.
		container node requestNewSkin ].
	self requestLayout
]

{ #category : #accessing }
ToTabListElement >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabListElement >> atStartSide: aBoolean [

	atStartSide = aBoolean ifTrue: [ ^ self ].
	atStartSide := aBoolean.
	self requestConfiguration
]

{ #category : #accessing }
ToTabListElement >> defaultFakeDataItem [

	^ ToTabItemElement new
		  labelText: 'X';
		  yourself
]

{ #category : #initialization }
ToTabListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeFactory: [ :holder | ToTabNode new ];
		  yourself
]

{ #category : #initialization }
ToTabListElement >> initialize [ 

	super initialize.
	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true.
	atStartSide := true
]

{ #category : #testing }
ToTabListElement >> isAtEndSide [ 

	^ self isAtStartSide not
]

{ #category : #testing }
ToTabListElement >> isAtStartSide [

	^ atStartSide
]

{ #category : #skin }
ToTabListElement >> newRawSkin [ 

	^ ToTabListElementSkin new
]
