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

{ #category : #'t - bar element' }
ToMenuItemFiniteListElement >> defaultInnerElementClass [

	^ ToMenuInnerBarElement
]

{ #category : #'t - item bar element - accessing' }
ToMenuItemFiniteListElement >> defaultNodeManagerClass [

	^ ToMenuItemNodeManager
]

{ #category : #initialization }
ToMenuItemFiniteListElement >> initialize [

	super initialize.
	
	self flag: 'no focusability until focus management is understood and working '.
	self focusability: BlFocusability none.
	self vertical: true.	
	self isFlowable: false.
	self fitContent.
	self uniformNodeWidth: true.
	"No visible primary selection"
	self selectionOption masked: true
]

{ #category : #skin }
ToMenuItemFiniteListElement >> newRawSkin [ 

	^ ToMenuItemBarElementSkin new
]
