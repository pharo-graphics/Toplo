Class {
	#name : #ToMenuOldBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'xmenu',
		'tmenu'
	],
	#category : #'Toplo-MenuRegistration-Clean'
}

{ #category : #running }
ToMenuOldBuilderTest >> menuBuilder: aClass [

	^ (aClass pragmaKeyword: #worldMenu model: self)
		  menuSpec;
		  yourself
]

{ #category : #tests }
ToMenuOldBuilderTest >> testEasyOld [

	| xSettings |
	xmenu := self menuBuilder: PragmaMenuBuilder.
	xSettings := (xmenu itemNamed: #Pharo) itemNamed: #Settings.
	self halt.
	xmenu allMisplacedItems
]

{ #category : #tests }
ToMenuOldBuilderTest >> testItemCurrentRootWithoutWith [

	| aBuilder item |
	aBuilder := MenuRegistration new owner: PragmaMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here'.
	
	(aBuilder item: #MyOwnCoolTool)
		parent: #MyOwnCoolMenu.
	
"	item := (aBuilder owner itemNamed: #MyOwnCoolMenu).
	self assert: item name equals: #MyOwnCoolMenu.
	self assert: item parentName equals: #Tools."
	item := aBuilder owner itemNamed: #MyOwnCoolTool.
	self assert: item parentName equals: #MyOwnCoolMenu.
	self halt.
	self assert: item owner currentRoot.
]

{ #category : #tests }
ToMenuOldBuilderTest >> testNestedItemAsGroup [

	| aBuilder nestedItem top |
	aBuilder := MenuRegistration new owner: PragmaMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here'.
	
	(aBuilder item: #MyOwnCoolTool)
		parent: #MyOwnCoolMenu;
		label: 'My own cool tool also here';
		action: [ 'aString' ].
	
	aBuilder owner interpretRegistration: aBuilder.
	top := (aBuilder owner itemNamed: #MyOwnCoolMenu).
	self assert: top name equals: #MyOwnCoolMenu.
	self assert: top parentName equals: #Tools.
	nestedItem := aBuilder owner itemNamed: #MyOwnCoolTool.
	self assert: nestedItem parentName equals: #MyOwnCoolMenu
]

{ #category : #tests }
ToMenuOldBuilderTest >> testNestedItemAsGroup2 [

	| aBuilder nestedItem  top |
	aBuilder := MenuRegistration new owner: PragmaMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here'.
	
	(aBuilder item: #MyOwnCoolTool)
		parent: #MyOwnCoolMenu;
		label: 'My own cool tool also here';
		action: [ 'aString' ].
	
	aBuilder owner interpretRegistration: aBuilder.
	top := (aBuilder owner itemNamed: #MyOwnCoolMenu).
	self assert: top name equals: #MyOwnCoolMenu.
	self assert: top parentName equals: #Tools.
	nestedItem := aBuilder owner itemNamed: #MyOwnCoolTool.
	self assert: nestedItem parentName equals: #MyOwnCoolMenu
]

{ #category : #tests }
ToMenuOldBuilderTest >> testNestedItemSpecifiedWithWithAsGroup [

	| aBuilder nestedItem top |
	aBuilder := MenuRegistration new owner: PragmaMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(aBuilder item: #MyOwnCoolTool)
				label: 'My own cool tool also here';
				action: [ 'aString' ] ].
	
	top := (aBuilder owner itemNamed: #MyOwnCoolMenu).
	self assert: top name equals: #MyOwnCoolMenu.
	self assert: top parentName equals: #Tools.
	nestedItem := aBuilder owner itemNamed: #MyOwnCoolTool.

	self assert: nestedItem parentName equals: nil.
	"This is nil because we did not invoke interpretRegistration:"
]

{ #category : #tests }
ToMenuOldBuilderTest >> testOrphanParentAndNestedWithParentMisplaced [

	| aBuilder stock |
	aBuilder := MenuRegistration new owner: PragmaMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(aBuilder item: #MyOwnCoolTool)
				parent: #swghjk;
				label: 'My own cool tool also here';
				action: [ 'aString' ] ].
	aBuilder owner interpretRegistration: aBuilder.
	stock := aBuilder owner allMisplacedItems.
	self assert: stock size equals: 2.

]

{ #category : #tests }
ToMenuOldBuilderTest >> testOrphanParentIsConsideredAsMisplace [

	| aBuilder nestedItem top stock |
	aBuilder := MenuRegistration new owner: PragmaMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(aBuilder item: #MyOwnCoolTool)
				label: 'My own cool tool also here';
				action: [ 'aString' ] ].
			
	aBuilder owner interpretRegistration: aBuilder.
	stock := aBuilder owner allMisplacedItems.
	self assert: stock size equals: 1
	.
	top := (aBuilder owner itemNamed: #MyOwnCoolMenu).
	self assert: top name equals: #MyOwnCoolMenu.
	self assert: top parentName equals: #Tools.
	nestedItem := aBuilder owner itemNamed: #MyOwnCoolTool.

	
]
