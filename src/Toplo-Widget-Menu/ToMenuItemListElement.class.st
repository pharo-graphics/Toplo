Class {
	#name : #ToMenuItemListElement,
	#superclass : #ToItemListElement,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #'t - bar element' }
ToMenuItemListElement >> configureLayout [

	self isHorizontal
		ifTrue: [ self hMatchParent. self vFitContent ]
		ifFalse: [ self vMatchParent. self hFitContent ].
	super configureLayout
]

{ #category : #initialization }
ToMenuItemListElement >> defaultNodeManager [ 

	^ToMenuItemNodeManager new
]

{ #category : #'t - orientable - orientation' }
ToMenuItemListElement >> horizontal: aBoolean [

	super horizontal: aBoolean.

]

{ #category : #initialization }
ToMenuItemListElement >> initialize [

	super initialize.
	
	self flag: 'no focusability until focus management is understood and working '.
	self focusability: BlFocusability none.
	
	self nodeWrapping: true.
	self fitContent.
	self vertical: true.
	self uniformNodeWidth: true.
	self selectionOption masked: true.
	self configureLayout
]

{ #category : #skin }
ToMenuItemListElement >> newRawSkin [ 

	^ ToMenuItemListElementSkin new
]
