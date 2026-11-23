"
I check that the skin of a `ToTabPaneListElement` gives the list its own selection elements, and gives back the previous ones when it is uninstalled.
"
Class {
	#name : #ToTabPaneListElementTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Widget-TabPane-Tests'
}

{ #category : #helpers }
ToTabPaneListElementTest >> newOpenList [

	^ self open: ToTabPaneListElement new matchParent
]

{ #category : #helpers }
ToTabPaneListElementTest >> open: aList [
	"Put the list in the space, so that it gets its skin, and answer it."

	space root addChild: aList.
	self settle.
	^ aList
]

{ #category : #helpers }
ToTabPaneListElementTest >> settle [

	5 timesRepeat: [ space settle ]
]

{ #category : #tests }
ToTabPaneListElementTest >> testSkinInstallsSelectionFactories [

	| list |
	list := self newOpenList.
	self assert: list selectionOption elementFactory value class equals: ToTabListPrimarySelectionElement.
	self assert: list secondarySelectionOption elementFactory value class equals: ToTabListSecondarySelectionElement
]

{ #category : #tests }
ToTabPaneListElementTest >> testUninstallingSkinAfterReinstallationRestoresSelectionFactories [

	| list primaryFactory secondaryFactory |
	list := ToTabPaneListElement new matchParent.
	primaryFactory := list selectionOption elementFactory.
	secondaryFactory := list secondarySelectionOption elementFactory.
	self open: list.
	list requestNewSkin.
	self settle.
	self assert: list selectionOption elementFactory value class equals: ToTabListPrimarySelectionElement.
	list withNullSkin.
	self settle.
	self assert: list selectionOption elementFactory identicalTo: primaryFactory.
	self assert: list secondarySelectionOption elementFactory identicalTo: secondaryFactory
]

{ #category : #tests }
ToTabPaneListElementTest >> testUninstallingSkinRestoresSelectionFactories [

	| list primaryFactory secondaryFactory |
	list := ToTabPaneListElement new matchParent.
	primaryFactory := list selectionOption elementFactory.
	secondaryFactory := list secondarySelectionOption elementFactory.
	self open: list.
	list withNullSkin.
	self settle.
	self assert: list selectionOption elementFactory identicalTo: primaryFactory.
	self assert: list secondarySelectionOption elementFactory identicalTo: secondaryFactory
]
