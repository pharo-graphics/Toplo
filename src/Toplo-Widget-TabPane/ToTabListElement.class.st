Class {
	#name : #ToTabListElement,
	#superclass : #ToCheckableListElement,
	#instVars : [
		'atStartSide'
	],
	#category : #'Toplo-Widget-TabPane-TabList'
}

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

{ #category : #'t - finite list element - fake container' }
ToTabListElement >> defaultFakeDataItem [

	^ ToTabItemElement new
		  labelText: 'X';
		  yourself
]

{ #category : #initialization }
ToTabListElement >> defaultInnerElementClass [

	^ ToScrollableFiniteListElement
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

{ #category : #configuration }
ToTabListElement >> newToConfiguration [ 

	^ ToTabListConfiguration new
]
