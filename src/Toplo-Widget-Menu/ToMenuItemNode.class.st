Class {
	#name : #ToMenuItemNode,
	#superclass : #ToItemNode,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'hooks - layout' }
ToMenuItemNode >> onLayoutDone [

	super onLayoutDone.
	"(self item isKindOf: ToSeparatorMenuItem ) ifTrue: [ self halt ]"
]
