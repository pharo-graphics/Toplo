"
I'm a list whose node contents is a menu item element.
"
Class {
	#name : #ToMenuItemListElement,
	#superclass : #ToItemFiniteListElement,
	#traits : 'TToMenuItemList',
	#classTraits : 'TToMenuItemList classTrait',
	#category : #'Toplo-Widget-Menu-ItemBar'
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
	self toConfiguration isFlowable: false.
	self fitContent.
	self toConfiguration uniformNodeWidth: true.
	"No visible primary selection"
	self selectionOption masked: true
]

{ #category : #skin }
ToMenuItemListElement >> newRawSkin [ 

	^ ToMenuItemListElementSkin new
]

{ #category : #configuration }
ToMenuItemListElement >> newToConfiguration [ 

	^ ToMenuItemListElementConfiguration new
]
