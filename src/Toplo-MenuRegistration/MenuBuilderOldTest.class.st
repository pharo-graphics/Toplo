Class {
	#name : #MenuBuilderOldTest,
	#superclass : #TestCase,
	#instVars : [
		'toploExampleMenu',
		'worldMenuExample'
	],
	#category : #'Toplo-MenuRegistration-Old'
}

{ #category : #'tests - before resolution' }
MenuBuilderOldTest >> testBeforeResolveSimpleItemNoParentAvailable [

	| builder |
	builder := ToMenuBuilderOld new.
	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	self 
		assert: builder collectedItems size 
		equals: 1.
	self 
		assert: builder collectedItems first parent 
		equals: #Tools
]

{ #category : #'tests - pragma' }
MenuBuilderOldTest >> testBuilderBeforePragmasCollectedItems [

	| builder |
	builder := ToMenuBuilderOld pragmaKeyword: #toploWorldMenu1.
	builder collectRegistrations.
	self 
		assert: builder collectedItems size 
		equals: 3.
		
	self assert: (builder indexOfChildNamed: 'RootWithTwoChildren') equals: 1.
	self assert: (builder indexOfChildNamed: 'Child1') equals: 2.
	self assert: (builder indexOfChildNamed: 'Child2') equals: 3.
	
]

{ #category : #'tests - pragma' }
MenuBuilderOldTest >> testBuilderCollectsAndResolvesPragmasCollectedItems [
	
	| builder |
	builder := ToMenuBuilderOld pragmaKeywords: { #toploWorldMenu1 }.
	builder 
		collectRegistrations; 	
		resolve.
	self assert: builder collectedItems size equals: 1.
	self assert: builder collectedItems first name equals:  'RootWithTwoChildren'.
	self assert: builder collectedItems first childrenItems size equals: 2.
]

{ #category : #'tests - pragma' }
MenuBuilderOldTest >> testBuilderCollectsItems [
	
	| builder namesOfItems |
	builder := ToMenuBuilderOld pragmaKeywords: { #toploWorldMenu1 }.
	builder collectRegistrations. 	
	self assert: builder collectedItems size equals: 3. 
	
	namesOfItems := { 'RootWithTwoChildren' . 'Child1' . 'Child2' }. 
	builder collectedItems do: [ :each | self assert: (namesOfItems includes: each name) ].
	
]

{ #category : #'tests - pragma' }
MenuBuilderOldTest >> testBuilderPragmas [

	| prgas |
	prgas := self toploExampleMenu pragmas.
	self 
		assert: prgas size 
		equals: 1.
	self 
		assert: prgas first selector
		equals: #toploWorldMenu1.
		
]

{ #category : #'tests - conflicts' }
MenuBuilderOldTest >> testDefinitionOfTwoSimilarParentIsAConflict [

	| builder |
	builder := ToMenuBuilderOld new.
	(builder item: #Tools) label: 'The root tools'.

	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	(builder item: #Tools) label: 'The root tools'.
	
	self assert: builder hasConflict
]

{ #category : #'tests - diff' }
MenuBuilderOldTest >> testDiffBrowseMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #Browsing.

	listWorldItemName := (concernItem itemNamed: #Browsing) itemList
		                     collect: [ :child | child name ].
	self assert: (concernItem itemNamed: #Browsing) itemList size equals: 3.
	self
		assert: (concernItem itemNamed: #Browsing) itemList size
		equals:
		((aBuilder itemsNamed: #Browse) childrenFromGroup: #Browsing) size.
	self
		assert:
			(((aBuilder itemsNamed: #Browse) childrenFromGroup: #Browsing)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
MenuBuilderOldTest >> testDiffDebugMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #Debug.
	listWorldItemName := (concernItem itemNamed: #Profiling) itemList
		                     collect: [ :child | child name ].
	self
		assert: (concernItem itemNamed: #Profiling) itemList size
		equals: 3.
	self
		assert: (concernItem itemNamed: #Profiling) itemList size
		equals:
		((aBuilder itemsNamed: #Debug) childrenFromGroup: #Profiling) size.
	self
		assert:
			(((aBuilder itemsNamed: #Debug) childrenFromGroup: #Profiling)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
MenuBuilderOldTest >> testDiffPharoMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #Pharo.
	listWorldItemName := (concernItem itemNamed: #Saving) itemList
		                     collect: [ :child | child name ].
	self assert: (concernItem itemNamed: #Saving) itemList size equals: 3.
	self
		assert: (concernItem itemNamed: #Saving) itemList size
		equals:
		((aBuilder itemsNamed: #Pharo) childrenFromGroup: #Saving) size.
	self
		assert:
			(((aBuilder itemsNamed: #Pharo) childrenFromGroup: #Saving)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
MenuBuilderOldTest >> testDiffSourcesMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #Sources.
	listWorldItemName := (concernItem itemNamed: #Refactoring) itemList
		                     collect: [ :child | child name ].
	self
		assert: (concernItem itemNamed: #Refactoring) itemList size
		equals: 2.
	self
		assert: (concernItem itemNamed: #Refactoring) itemList size
		equals:
		((aBuilder itemsNamed: #Sources) childrenFromGroup: #Refactoring) size.
	self
		assert:
			(((aBuilder itemsNamed: #Sources) childrenFromGroup: #Refactoring)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
MenuBuilderOldTest >> testDiffSystemMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #System.

	listWorldItemName := (concernItem itemNamed: #World) itemList
		                     collect: [ :child | child name ].
	self assert: (concernItem itemNamed: #World) itemList size equals: 3.
	self
		assert: (concernItem itemNamed: #World) itemList size
		equals:
		((aBuilder itemsNamed: #System) childrenFromGroup: #World) size.
	self
		assert:
			(((aBuilder itemsNamed: #System) childrenFromGroup: #World)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - conflicts' }
MenuBuilderOldTest >> testDuplicatedIdenticalItem [

	| builder |
	builder := ToMenuBuilderOld new.

	builder item: #MyOwnCoolMenu.
	builder item: #MyOwnCoolMenu.

	self assert: builder collectedItems size equals: 1.
	self assert: builder hasConflict
]

{ #category : #'tests - conflicts' }
MenuBuilderOldTest >> testDuplicatedIdenticalItemShortcut [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #PrettyMenu) shortcut: 'u'.
	(builder item: #UglyMenu) shortcut: 'u'.
	builder resolve.
	self assert: builder collectedItems size equals: 2.
	self assert: builder hasConflict.
]

{ #category : #'tests - conflicts' }
MenuBuilderOldTest >> testDuplicatedIdenticalItemWithChild [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobbyLeMenu ].
	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobbyLeMenu ].
	builder resolve.
	self 
		assert: builder collectedItems size 
		equals: 1.
	self
		assert: builder collectedItems first childrenItems size
		equals: 1.
	self
		assert: builder hasConflict
]

{ #category : #'tests - conflicts' }
MenuBuilderOldTest >> testDuplicatedIdenticalItemWithDifferentChild [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobbyLeMenu ].
	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobLeMenu ].
	builder resolve.
	self 
		assert: builder collectedItems size 
		equals: 1.
	self
		assert: builder collectedItems first childrenItems size
		equals: 2.
	self 
		assert: builder hasConflict
]

{ #category : #'tests - groups' }
MenuBuilderOldTest >> testItemInAnUndeclaredGroupCreatesGroup [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #Tools)
		label: 'The root tools';
		groupName: #OurGroup.

	builder resolve.
	self 
		assert: builder groups size 
		equals: 1.
	self assert: (builder groups includes: #OurGroup).
	self 
		assert: (builder groupsNamed: #OurGroup) childrenItems first name 
		equals: #Tools
]

{ #category : #'tests - groups' }
MenuBuilderOldTest >> testItemInGroupAlreadyDeclared [

	| builder |
	builder := ToMenuBuilderOld new.
	builder group: #OurGroup.

	(builder item: #Tools)
		label: 'The root tools';
		groupName: #OurGroup.
	builder resolve.
	self flag: #tofix. 
	"We should only get one item: the group and it should have tools as children"
	self 
		assert: builder collectedItems size 
		equals: 2.
	self
		assert: (builder groupsNamed: #OurGroup) childrenItems first name
		equals: #Tools
]

{ #category : #tests }
MenuBuilderOldTest >> testOrderedTree [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyMenu)
		order: 3;
		with: [
			(builder item: #MyMenuChild1)
				parent: #MyMenu;
				order: 9999.
			(builder item: #MyMenuChild2)
				parent: #MyMenu;
				order: 1 ].
	(builder item: #MySecondMenu)
		order: 1;
		with: [
			(builder item: #MySecondMenuChild1)
				parent: #MySecondMenu;
				order: 9999.
			(builder item: #MySecondMenuChild2)
				parent: #MySecondMenu;
				order: 1 ].
	builder resolve.

	self 
		assert: builder collectedItems first name 
		equals: #MySecondMenu.
	self 
		assert: builder collectedItems last name 
		equals: #MyMenu.
	self
		assert: (builder itemsNamed: #MySecondMenu) childrenItems first name
		equals: #MySecondMenuChild2
]

{ #category : #'tests - todo' }
MenuBuilderOldTest >> testResolveAnUnknownParent [

	| builder |
	builder := ToMenuBuilderOld new.
	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	builder resolve.
	self
		assert: (builder itemsNamed: #MyOwnCoolTool) parent
		equals: #Tools.
	self assert:
		(builder itemsNamed: #MyOwnCoolTool) parentMenuItem isNil.

	self assert: builder hasConflict.
	self assert: builder conflicts first class equals: ParentNotFound
]

{ #category : #'tests - duplicated items' }
MenuBuilderOldTest >> testResolveThreeDepth [

	| builder |
	builder := ToMenuBuilderOld new.
	(builder item: #Root) label: 'The root tools'.

	(builder item: #Sub)
		parent: #Root;
		label: 'A subitem'.

	(builder item: #SubSub)
		parent: #Sub;
		label: 'A subsubitem'.

	builder resolve.

	self assert: builder collectedItems size equals: 1
]

{ #category : #'tests - duplicated items' }
MenuBuilderOldTest >> testResolveThreeDepthBroken [

	| builder |
	builder := ToMenuBuilderOld new.
	(builder item: #Root) label: 'The root tools'.

	(builder item: #Sub)
		parent: #Root;
		label: 'A subitem'.

	(builder item: #SubSub)
		parent: #SubBroken;
		label: 'A subsubitem'.

	builder resolve.

	self assert: builder collectedItems size equals: 2
]

{ #category : #'tests - resolve phase' }
MenuBuilderOldTest >> testResolveWithDeclaresOneItemWithAChild [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyMenuChild)
				parent: #MyMenu;
				label: 'My own cool tool also here' ].

	builder resolve.

	"The parent item is not defined and the resolve phase does not define it."
	self assert: builder collectedItems size equals: 1.
	self assert: builder collectedItems first name equals: #MyMenu.

	self assert: builder conflicts first class equals: ParentNotFound.
	
	self
		assert:
		(builder itemsNamed: #MyMenu) childrenItems first label
		equals: 'My own cool tool also here'.

	self
		assert:
		(builder itemsNamed: #MyMenu) childrenItems first parent
		equals: #MyMenu
]

{ #category : #'tests - resolve phase' }
MenuBuilderOldTest >> testResolveWithDeclaresOneItemWithAParentAndAChild [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyMenu)
		parent: #Tools;
		groupName: #BeautifulMenu;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyMenuChild)
				parent: #MyMenu;
				label: 'My own cool tool also here' ].

	builder resolve.
	self assert: builder groups size equals: 1.
	self
		assert: (builder groupsNamed: #BeautifulMenu) childrenItems size
		equals: 2.
	self
		assert:
			((builder groupsNamed: #BeautifulMenu) childrenItems collect: [
				 :item | item name ])
		equals: { #MyMenu. #MyMenuChild } asOrderedCollection.
	self
		assert: (builder itemsNamed: #MyMenu) childrenItems first parent
		equals: #MyMenu
]

{ #category : #'tests - resolve phase' }
MenuBuilderOldTest >> testResolveWithItemWithExplicitParentUnknowDeclared [

	| builder |
	builder := ToMenuBuilderOld new.
	(builder item: #MyMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyBrokenItem)
				parent: #MyBrokenMenu;
				label: 'My own cool tool also here'.
			(builder item: #MyItem)
				parent: #MyMenu;
				label: 'My own cool tool also here' ].
	builder resolve.

	"
		When we use a with, it force to correct the explicit unknown parent/wrong parent placement
	"
	self assert: builder collectedItems size equals: 1.

	self
		assert: (builder itemsNamed: #MyMenu) childrenItems first name
		equals: #MyBrokenItem.

	self
		assert: (builder itemsNamed: #MyMenu) childrenItems first parent
		equals: #MyMenu.
]

{ #category : #'tests - before resolution' }
MenuBuilderOldTest >> testSimpleItemBeforeParentDefinition [

	| builder |
	builder := ToMenuBuilderOld new.
	
	"we create a first item whose parent will be created after"
	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	"we create its parent after"
	(builder item: #Tools) 
		label: 'The root tools'.

	self 
		assert: builder collectedItems size 
		equals: 2.
	self 
		assert: builder collectedItems first parent 
		equals: #Tools
]

{ #category : #'tests - resolve phase' }
MenuBuilderOldTest >> testSimpleItemWithItemNoParentDeclared [

	| builder conflict |
	builder := ToMenuBuilderOld new.

	(builder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool) label: 'My own cool tool also here' ].
	builder resolve.

	self assert: builder collectedItems size equals: 1.
	self assert: builder collectedItems first name equals: #MyOwnCoolMenu.
	conflict := builder conflicts first.
	self assert: conflict class equals: ParentNotFound.
	self assert: conflict name equals: #Tools.
	self assert: conflict itemName equals: #MyOwnCoolMenu.




	self
		assert: (builder itemsNamed: #MyOwnCoolMenu) parent
		equals: #Tools.
	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first parent
		equals: #MyOwnCoolMenu
]

{ #category : #'tests - resolve phase' }
MenuBuilderOldTest >> testSimpleItemWithItemWhoHaveAChild [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyOwnCoolMenu)
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool)
				label: 'My own cool tool also here';
				with: [
					(builder item: #MyOwnCoolTool2) label:
							'My own cool tool 2 also here'.]].
	builder resolve.

	self assert: builder collectedItems size equals: 1.

	self
		assert:
		(builder itemsNamed: #MyOwnCoolMenu) childrenItems first label
		equals: 'My own cool tool also here'.
	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				childrenItems size
		equals: 1.
	self
		assert: ((builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				 findChildrenItems: #MyOwnCoolTool2) label
		equals: 'My own cool tool 2 also here'.
]

{ #category : #'tests - resolve phase' }
MenuBuilderOldTest >> testSimpleItemWithItemWithExplicitParentDeclared [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool)
				parent: #MyOwnCoolMenu;
				label: 'My own cool tool also here' ].
	builder resolve.

	self assert: builder collectedItems size equals: 1.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				parent
		equals: #MyOwnCoolMenu
]

{ #category : #'tests - resolve phase' }
MenuBuilderOldTest >> testSimpleItemWithMultiplesItemsWithExpliciteDeclaredParent [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool)
				parent: #MyOwnCoolMenu;
				label: 'My own cool tool also here'.
			(builder item: #MyOwnCoolTool2)
				parent: #MyOwnCoolMenu;
				label: 'My own cool tool 2 also here' ].
	builder resolve.

	self assert: builder collectedItems size equals: 1.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.
	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems second
				label
		equals: 'My own cool tool 2 also here'.
]

{ #category : #'tests - resolve phase' }
MenuBuilderOldTest >> testSimpleItemWithMultiplesItemsWithNoParentDeclared [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool)
				label: 'My own cool tool also here'.
			(builder item: #MyOwnCoolTool2)
				label: 'My own cool tool 2 also here' ].
	builder resolve.

	self assert: builder collectedItems size equals: 1.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.
	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems second
				label
		equals: 'My own cool tool 2 also here'.
]

{ #category : #'tests - duplicated items' }
MenuBuilderOldTest >> testThreeDepth [

	| builder |
	builder := ToMenuBuilderOld new.
	(builder item: #Root) label: 'The root tools'.

	(builder item: #Sub)
		parent: #Root;
		label: 'A subitem'.

	(builder item: #SubSub)
		parent: #Sub;
		label: 'A subsubitem'.


	self assert: builder collectedItems size equals: 3
]

{ #category : #'tests - groups' }
MenuBuilderOldTest >> testTwoGroupDeclarationWithSameNameCreatesOnlyOneGroup [
	| builder |
	builder := ToMenuBuilderOld new.
	builder group: #OurGroup.
	builder group: #OurGroup.
	builder resolve.
	
	self 
		assert: builder collectedItems size 
		equals: 2.
	self
		assert: (builder groupsNamed: #OurGroup) childrenItems first name
		equals: #Tools
]

{ #category : #'tests - todo' }
MenuBuilderOldTest >> testTwoGroupsWithSameName [

	| builder |
	builder := ToMenuBuilderOld new.
	
	(builder group: #Tools) label: 'The root tools'.
	(builder group: #Tools) label: 'The root tools'.

	self 
		assert: builder groups size 
		equals: 1.
	self assert: (builder groups includes: #Tools).
]

{ #category : #tests }
MenuBuilderOldTest >> testWithDeclaresOneItemWithAChild [

	| builder |
	builder := ToMenuBuilderOld new.

	(builder item: #MyMenu)
		parent: #Tools;
		"place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [
			(builder item: #MyMenuChild)
				parent: #MyMenu;
				label: 'My own cool tool also here' ].

	"At this stage (before resolving) the child is created by the builder but not in the parent list and 
	as such removed from the collected items."

	self assert: builder collectedItems size equals: 2.

	self
		assert: (builder itemsNamed: #MyMenuChild) parent
		equals: #MyMenu.

	self
		assert: (builder itemsNamed: #MyMenuChild) parent
		equals: #MyMenu.

	self
		assert: (builder itemsNamed: #MyMenuChild) label
		equals: 'My own cool tool also here'
]

{ #category : #examples }
MenuBuilderOldTest >> toploExampleMenu [

	^ toploExampleMenu ifNil: [ 
			toploExampleMenu := self toploExampleMenuBuilder: ToMenuBuilderOld ]
]

{ #category : #examples }
MenuBuilderOldTest >> toploExampleMenuBuilder: aBuilderClass [

	^ (aBuilderClass pragmaKeyword: #toploWorldMenu1)
		  collectRegistrations;
		  resolve;
		  yourself
]

{ #category : #'world menu' }
MenuBuilderOldTest >> worldMenuExampleExampleMenu [

	^ worldMenuExample ifNil: [
		  worldMenuExample := self worldMenuExampleMenuBuilder: ToMenuBuilderOld ]
]

{ #category : #'world menu' }
MenuBuilderOldTest >> worldMenuExampleMenuBuilder: aClass [

	^ (aClass pragmaKeyword: #worldMenu)
		  collectRegistrations;
		  resolve;
		  yourself
]
