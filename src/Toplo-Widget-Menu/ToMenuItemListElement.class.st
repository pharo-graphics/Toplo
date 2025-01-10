"
I'm a list whose node contents is a menu item element.
"
Class {
	#name : #ToMenuItemListElement,
	#superclass : #ToItemListElement,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #'t - list node holder' }
ToMenuItemListElement >> configureLayoutIn: aListHolder [

	self horizontal: aListHolder isHorizontal.
	aListHolder isHMatchParent
		ifTrue: [ self hMatchParent ]
		ifFalse: [ self hFitContent ].
	aListHolder isVMatchParent
		ifTrue: [ self vMatchParent ]
		ifFalse: [ self vFitContent ]
]

{ #category : #initialization }
ToMenuItemListElement >> defaultNodeManager [

	^ ToMenuItemNodeManager new
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
