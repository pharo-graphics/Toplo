"
I'm a list whose node contents is a menu item element.
"
Class {
	#name : #ToMenuItemBarElement,
	#superclass : #ToItemBarElement,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'t - list node holder' }
ToMenuItemBarElement >> configureLayoutIn: aListHolder [

	self horizontal: aListHolder isHorizontal.
	aListHolder isHMatchParent
		ifTrue: [ self hMatchParent ]
		ifFalse: [ self hFitContent ].
	aListHolder isVMatchParent
		ifTrue: [ self vMatchParent ]
		ifFalse: [ self vFitContent ]
]

{ #category : #initialization }
ToMenuItemBarElement >> defaultNodeManager [

	^ ToMenuItemNodeManager new
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
