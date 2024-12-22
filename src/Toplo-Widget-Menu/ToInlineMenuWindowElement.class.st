Class {
	#name : #ToInlineMenuWindowElement,
	#superclass : #ToInlineWindowElement,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #testing }
ToInlineMenuWindowElement >> includes: anElement [

	self = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ false
]

{ #category : #initialization }
ToInlineMenuWindowElement >> initialize [ 

	super initialize.
	self hMatchParent
]

{ #category : #accessing }
ToInlineMenuWindowElement >> itemContainer [

	^ self element
]

{ #category : #testing }
ToInlineMenuWindowElement >> items [

	^ self itemContainer ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - menu window model' }
ToInlineMenuWindowElement >> menuWindow [

	^ self
]

{ #category : #'instance creation' }
ToInlineMenuWindowElement >> newRawSkin [ 

	^ ToInlineMenuWindowSkin new
]

{ #category : #'api - displaying' }
ToInlineMenuWindowElement >> toThemeInstalled [

	| lt |
	self element ifNotNil: [ :e |
		lt := e lookupTheme.
		self localTheme = lt ifFalse: [ self localTheme: lt ] ].
	super toThemeInstalled
]

{ #category : #enumerating }
ToInlineMenuWindowElement >> withAllSubwindowsDo: aBlock [

	self items do: [ :i | i menuWindowDo: [ :w | w withAllSubwindowsDo: aBlock ] ].
	super withAllSubwindowsDo: aBlock
]
