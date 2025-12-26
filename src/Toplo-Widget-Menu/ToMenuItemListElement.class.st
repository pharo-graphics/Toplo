"
I'm a list whose node contents is a menu item element.
"
Class {
	#name : #ToMenuItemListElement,
	#superclass : #ToItemFiniteListElement,
	#traits : 'TToFiniteListElement + TToMenuItemList',
	#classTraits : 'TToFiniteListElement classTrait + TToMenuItemList classTrait',
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #initialization }
ToMenuItemListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeFactory: [ :holder | ToMenuItemNode new ];
		  yourself
]

{ #category : #initialization }
ToMenuItemListElement >> initialize [

	super initialize.

	self flag:
		'no focusability until focus management is understood and working '.
	self focusability: BlFocusability none.
	self vertical: true.
	"No visible primary selection"
	self selectionOption masked: true
]

{ #category : #layout }
ToMenuItemListElement >> minNodeWidth [
	" in case of an inline menu, the item minWidth is forced to be its menuListOwner width"

	self menuListOwner ifNotNil: [ :menuOwner |
		menuOwner hasInlineWindow ifTrue: [ ^ menuOwner measuredWidth ] ].
	^ super minNodeWidth
]

{ #category : #skin }
ToMenuItemListElement >> newRawSkin [ 

	^ ToMenuItemListElementSkin new
]
