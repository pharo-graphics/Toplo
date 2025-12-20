"
I'm a list whose node contents is a menu item element.
"
Class {
	#name : #ToMenuItemFiniteListElement,
	#superclass : #ToItemFiniteListElement,
	#traits : 'TToMenuItemBar',
	#classTraits : 'TToMenuItemBar classTrait',
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #initialization }
ToMenuItemFiniteListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeFactory: [ :holder | ToMenuItemNode new ];
		  yourself
]

{ #category : #initialization }
ToMenuItemFiniteListElement >> initialize [

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
ToMenuItemFiniteListElement >> newRawSkin [ 

	^ ToMenuItemFiniteListElementSkin new
]

{ #category : #configuration }
ToMenuItemFiniteListElement >> newToConfiguration [ 

	^ ToMenuItemFiniteListElementConfiguration new
]
