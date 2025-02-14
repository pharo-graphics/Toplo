"
I'm a list whose node contents is a menu item element.
"
Class {
	#name : #ToMenuItemBarElement,
	#superclass : #ToItemBarElement,
	#traits : 'TToMenuItemBar',
	#classTraits : 'TToMenuItemBar classTrait',
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'t - list node holder' }
ToMenuItemBarElement >> configureLayoutIn: anItemBarOwner [

	self horizontal: anItemBarOwner isHorizontal.
	anItemBarOwner isHMatchParent
		ifTrue: [ self hMatchParent ]
		ifFalse: [ self hFitContent ].
	anItemBarOwner isVMatchParent
		ifTrue: [ self vMatchParent ]
		ifFalse: [ self vFitContent ].
	self configureLayout
]

{ #category : #'t - bar element' }
ToMenuItemBarElement >> defaultInnerElement [

	^ ToMenuInnerBarElement onBarElement: self
]

{ #category : #'t - item bar element - accessing' }
ToMenuItemBarElement >> defaultNodeManagerClass [

	^ ToMenuItemNodeManager
]

{ #category : #initialization }
ToMenuItemBarElement >> initialize [

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
ToMenuItemBarElement >> newRawSkin [ 

	^ ToMenuItemBarElementSkin new
]
