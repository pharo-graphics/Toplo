Class {
	#name : #ToTabPaneHeaderElement,
	#superclass : #ToTripletContainer,
	#instVars : [
		'alignment',
		'compactLayoutMode'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #accessing }
ToTabPaneHeaderElement >> alignEnd [

	self alignment: BlElementAlignment end
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignMiddle [

	self alignment: BlElementAlignment middle
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignStart [ 

	self alignment: BlElementAlignment start
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignment [ 

	^ alignment
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignment: anElementAlignment [ 

	alignment := anElementAlignment.
	self requestConfiguration
]

{ #category : #accessing }
ToTabPaneHeaderElement >> compactLayoutMode: aBoolean [

	compactLayoutMode = aBoolean ifTrue: [ ^ self ].
	compactLayoutMode := aBoolean 
]

{ #category : #accessing }
ToTabPaneHeaderElement >> endExtraBuilder: aValuable [

	aValuable value: self endContainer
]

{ #category : #initialization }
ToTabPaneHeaderElement >> initialize [

	super initialize.
	compactLayoutMode := false.
	self createStartContainer.
	self createEndContainer.
	self startContainer id: #'start-extra-container'.
	self endContainer id: #'end-extra-container'.
	self noAlignment
]

{ #category : #accessing }
ToTabPaneHeaderElement >> invisibleNodes [ 

	^ self tabGroup invisibleNodes
]

{ #category : #accessing }
ToTabPaneHeaderElement >> isAlignEnd [

	^ self alignment = BlElementAlignment end
]

{ #category : #accessing }
ToTabPaneHeaderElement >> isAlignMiddle [

	^ self alignment = BlElementAlignment middle
]

{ #category : #accessing }
ToTabPaneHeaderElement >> isAlignStart [

	^ self alignment = BlElementAlignment start
]

{ #category : #configuration }
ToTabPaneHeaderElement >> matchParentMode [

	^ self toConfiguration matchParentMode
]

{ #category : #configuration }
ToTabPaneHeaderElement >> matchParentMode: aBoolean [

	self toConfiguration matchParentMode = aBoolean ifTrue: [ ^ self ].
	self toConfiguration matchParentMode: aBoolean.
	self requestConfiguration
]

{ #category : #'t - triplet container - instance creation' }
ToTabPaneHeaderElement >> newEndContainer [ 

	^ self newLinearContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTabPaneHeaderElement >> newMiddleContainer [ 

	^ self newTabGroupElement
]

{ #category : #'t - triplet container - instance creation' }
ToTabPaneHeaderElement >> newStartContainer [ 

	^ self newLinearContainer
]

{ #category : #'instance creation' }
ToTabPaneHeaderElement >> newTabGroupElement [

	^ ToTabPaneGroupElement new
		  matchParent;
		  yourself
]

{ #category : #configuration }
ToTabPaneHeaderElement >> newToConfiguration [ 

	^ ToTabPaneHeaderConfiguration new
]

{ #category : #accessing }
ToTabPaneHeaderElement >> noAlignment [

	self alignment: BlElementAlignment null
]

{ #category : #accessing }
ToTabPaneHeaderElement >> startExtraBuilder: aValuable [

	aValuable value: self startContainer
]

{ #category : #accessing }
ToTabPaneHeaderElement >> tabGroup [ 

	^ self middleContainer 
]

{ #category : #accessing }
ToTabPaneHeaderElement >> trackElement [

	^ self tabGroup trackElement
]
