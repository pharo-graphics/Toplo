Class {
	#name : #ToMenuBuilderOTest,
	#superclass : #TestCase,
	#instVars : [
		'toploExampleMenu',
		'worldMenuExample',
		'builder'
	],
	#category : #'Toplo-MenuRegistration-O'
}

{ #category : #'tests - before resolution' }
ToMenuBuilderOTest >> setUp [

	builder := ToMenuBuilderO new.

]

{ #category : #'tests - before resolution' }
ToMenuBuilderOTest >> testBeforeResolveSimpleItemNoParentAvailable [

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
ToMenuBuilderOTest >> testBuilderBeforePragmasCollectedItems [

	builder pragmaKeywords: { #toploWorldMenu1}.
	builder collectDeclarations.
	self 
		assert: builder collectedItems size 
		equals: 3.
		
	self assert: (builder indexOfChildNamed: 'RootWithTwoChildren') equals: 1.
	self assert: (builder indexOfChildNamed: 'Child1') equals: 2.
	self assert: (builder indexOfChildNamed: 'Child2') equals: 3.
	
]

{ #category : #'tests - pragma' }
ToMenuBuilderOTest >> testBuilderCollectsAndResolvesPragmasCollectedItems [
	
	builder pragmaKeywords: { #toploWorldMenu1 }.
	builder 
		collectDeclarations; 	
		resolve.
	self assert: builder collectedItems size equals: 1.
	self assert: builder collectedItems first name equals:  'RootWithTwoChildren'.
	self assert: builder collectedItems first childrenItems size equals: 2.
]

{ #category : #'tests - pragma' }
ToMenuBuilderOTest >> testBuilderCollectsItems [
	
	| namesOfItems |
	builder pragmaKeywords: { #toploWorldMenu1 }.
	builder collectDeclarations. 	
	self assert: builder collectedItems size equals: 3. 
	
	namesOfItems := { 'RootWithTwoChildren' . 'Child1' . 'Child2' }. 
	builder collectedItems do: [ :each | self assert: (namesOfItems includes: each name) ].
	
]

{ #category : #'tests - pragma' }
ToMenuBuilderOTest >> testBuilderPragmas [

	| prgas |
	prgas := self toploExampleMenu pragmas.
	self 
		assert: prgas size 
		equals: 1.
	self 
		assert: prgas first selector
		equals: #toploWorldMenuXXX123.
		
]

{ #category : #'tests - conflicts' }
ToMenuBuilderOTest >> testDefinitionOfTwoSimilarParentIsAConflict [

	(builder item: #Tools) label: 'The root tools'.

	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	(builder item: #Tools) label: 'The root tools'.
	
	self assert: builder hasConflict
]

{ #category : #'tests - diff' }
ToMenuBuilderOTest >> testDiffBrowseMenu [

	| aBuilder morphicBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	morphicBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	morphicBuilder buildTree.
	concernItem := morphicBuilder itemNamed: #Browsing.

	listWorldItemName := (concernItem itemNamed: #Browsing) itemList
		                     collect: [ :child | child name ].
	self assert: (concernItem itemNamed: #Browsing) itemList size equals: 3.
	self
		assert: (concernItem itemNamed: #Browsing) itemList size
		equals:
		((aBuilder itemNamed: #Browse) childrenFromGroup: #Browsing) size.
	self
		assert:
			(((aBuilder itemNamed: #Browse) childrenFromGroup: #Browsing)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
ToMenuBuilderOTest >> testDiffDebugMenu [

	| aBuilder morphicBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	morphicBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	morphicBuilder buildTree.
	concernItem := morphicBuilder itemNamed: #Debug.
	listWorldItemName := (concernItem itemNamed: #Profiling) itemList
		                     collect: [ :child | child name ].
	self
		assert: (concernItem itemNamed: #Profiling) itemList size
		equals: 3.
	self
		assert: (concernItem itemNamed: #Profiling) itemList size
		equals:
		((aBuilder itemNamed: #Debug) childrenFromGroup: #Profiling) size.
	self
		assert:
			(((aBuilder itemNamed: #Debug) childrenFromGroup: #Profiling)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
ToMenuBuilderOTest >> testDiffPharoMenu [

	| aBuilder morphicBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	morphicBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	morphicBuilder buildTree.
	concernItem := morphicBuilder itemNamed: #Pharo.
	listWorldItemName := (concernItem itemNamed: #Saving) itemList
		                     collect: [ :child | child name ].
	self assert: (concernItem itemNamed: #Saving) itemList size equals: 3.
	self
		assert: (concernItem itemNamed: #Saving) itemList size
		equals:
		((aBuilder itemNamed: #Pharo) childrenFromGroup: #Saving) size.
	self
		assert:
			(((aBuilder itemNamed: #Pharo) childrenFromGroup: #Saving)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
ToMenuBuilderOTest >> testDiffSourcesMenu [

	| aBuilder morphicBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	morphicBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	morphicBuilder buildTree.
	concernItem := morphicBuilder itemNamed: #Sources.
	listWorldItemName := (concernItem itemNamed: #Refactoring) itemList
		                     collect: [ :child | child name ].
	self
		assert: (concernItem itemNamed: #Refactoring) itemList size
		equals: 2.
	self
		assert: (concernItem itemNamed: #Refactoring) itemList size
		equals:
		((aBuilder itemNamed: #Sources) childrenFromGroup: #Refactoring) size.
	self
		assert:
			(((aBuilder itemNamed: #Sources) childrenFromGroup: #Refactoring)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
ToMenuBuilderOTest >> testDiffSystemMenu [

	| aBuilder morphicBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	morphicBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	morphicBuilder buildTree.
	concernItem := morphicBuilder itemNamed: #System.

	listWorldItemName := (concernItem itemNamed: #World) itemList
		                     collect: [ :child | child name ].
	self assert: (concernItem itemNamed: #World) itemList size equals: 3.
	self
		assert: (concernItem itemNamed: #World) itemList size
		equals:
		((aBuilder itemNamed: #System) childrenFromGroup: #World) size.
	self
		assert:
			(((aBuilder itemNamed: #System) childrenFromGroup: #World)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - conflicts' }
ToMenuBuilderOTest >> testDuplicatedIdenticalItem [


	builder item: #MyOwnCoolMenu.
	builder item: #MyOwnCoolMenu.

	self assert: builder collectedItems size equals: 1.
	self assert: builder hasConflict
]

{ #category : #'tests - conflicts' }
ToMenuBuilderOTest >> testDuplicatedIdenticalItemShortcut [

	(builder item: #PrettyMenu) shortcut: 'u'.
	(builder item: #UglyMenu) shortcut: 'u'.
	builder resolve.
	self assert: builder collectedItems size equals: 2.
	self assert: builder hasConflict.
]

{ #category : #'tests - conflicts' }
ToMenuBuilderOTest >> testDuplicatedIdenticalItemWithChild [

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
ToMenuBuilderOTest >> testDuplicatedIdenticalItemWithDifferentChild [

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
ToMenuBuilderOTest >> testItemInAnUndeclaredGroupCreatesGroup [

	(builder item: #Tools)
		label: 'The root tools';
		groupName: #OurGroup.

	builder resolve.
	self 
		assert: builder namesOfAlreadyExistingGroups size 
		equals: 1.
	self assert: (builder namesOfAlreadyExistingGroups includes: #OurGroup).
	self 
		assert: (builder groupNamed: #OurGroup) childrenItems first name 
		equals: #Tools
]

{ #category : #'tests - groups' }
ToMenuBuilderOTest >> testItemInGroupAlreadyDeclared [

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
		assert: (builder groupNamed: #OurGroup) childrenItems first name
		equals: #Tools
]

{ #category : #'tests - groups' }
ToMenuBuilderOTest >> testItemNamed [

	(builder item: #Tools) label: 'The root tools'.
	self assert: (builder itemNamed: #Tools) name equals: #Tools.
	(builder item: #Tools2) label: 'The root tools 2'.
	self assert: (builder itemNamed: #Tools) name equals: #Tools.
	self assert: (builder itemNamed: #Tools2) name equals: #Tools2.
	
	(builder group: #OurGroup) parent: #Tools.
	(builder group: #OurGroup2) parent: #Tools.
	builder resolve.
	
	self assert: (builder itemNamed: #Tools) name equals: #Tools.
	self assert: (builder itemNamed: #Tools2) name equals: #Tools2.
	self assert: (builder itemNamed: #Tools2) name equals: #Tools2.
	
	
]

{ #category : #tests }
ToMenuBuilderOTest >> testOrderedTree [

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
		assert: (builder itemNamed: #MySecondMenu) childrenItems first name
		equals: #MySecondMenuChild2
]

{ #category : #'tests - todo' }
ToMenuBuilderOTest >> testResolveAnUnknownParent [

	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	builder resolve.
	self
		assert: (builder itemNamed: #MyOwnCoolTool) parent
		equals: #Tools.
	self assert:
		(builder itemNamed: #MyOwnCoolTool) parentMenuItem isNil.

	self assert: builder hasConflict.
	self assert: builder conflicts first class equals: ParentNotFound
]

{ #category : #'tests - duplicated items' }
ToMenuBuilderOTest >> testResolveThreeDepth [

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
ToMenuBuilderOTest >> testResolveThreeDepthBroken [

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
ToMenuBuilderOTest >> testResolveWithDeclaresOneItemWithAChild [

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
		(builder itemNamed: #MyMenu) childrenItems first label
		equals: 'My own cool tool also here'.

	self
		assert:
		(builder itemNamed: #MyMenu) childrenItems first parent
		equals: #MyMenu
]

{ #category : #'tests - resolve phase' }
ToMenuBuilderOTest >> testResolveWithDeclaresOneItemWithAParentAndAChild [

	(builder item: #MyMenu)
		parent: #Tools;
		groupName: #BeautifulMenu;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyMenuChild)
				parent: #MyMenu;
				label: 'My own cool tool also here' ].

	builder resolve.
	self assert: builder namesOfAlreadyExistingGroups size equals: 1.
	self
		assert: (builder groupNamed: #BeautifulMenu) childrenItems size
		equals: 2.
	self
		assert:
			((builder groupNamed: #BeautifulMenu) childrenItems collect: [
				 :item | item name ])
		equals: { #MyMenu. #MyMenuChild } asOrderedCollection.
	self
		assert: (builder itemNamed: #MyMenu) childrenItems first parent
		equals: #MyMenu
]

{ #category : #'tests - resolve phase' }
ToMenuBuilderOTest >> testResolveWithItemWithExplicitParentUnknowDeclared [

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
		assert: (builder itemNamed: #MyMenu) childrenItems first name
		equals: #MyBrokenItem.

	self
		assert: (builder itemNamed: #MyMenu) childrenItems first parent
		equals: #MyMenu.
]

{ #category : #'tests - before resolution' }
ToMenuBuilderOTest >> testSimpleItemBeforeParentDefinition [
	
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
ToMenuBuilderOTest >> testSimpleItemWithItemNoParentDeclared [

	| conflict |

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
		assert: (builder itemNamed: #MyOwnCoolMenu) parent
		equals: #Tools.
	self
		assert:
			(builder itemNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.

	self
		assert:
			(builder itemNamed: #MyOwnCoolMenu) childrenItems first parent
		equals: #MyOwnCoolMenu
]

{ #category : #'tests - resolve phase' }
ToMenuBuilderOTest >> testSimpleItemWithItemWhoHaveAChild [

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
		(builder itemNamed: #MyOwnCoolMenu) childrenItems first label
		equals: 'My own cool tool also here'.
	self
		assert:
			(builder itemNamed: #MyOwnCoolMenu) childrenItems first
				childrenItems size
		equals: 1.
	self
		assert: ((builder itemNamed: #MyOwnCoolMenu) childrenItems first
				 findChildrenItems: #MyOwnCoolTool2) label
		equals: 'My own cool tool 2 also here'.
]

{ #category : #'tests - resolve phase' }
ToMenuBuilderOTest >> testSimpleItemWithItemWithExplicitParentDeclared [

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
			(builder itemNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.

	self
		assert:
			(builder itemNamed: #MyOwnCoolMenu) childrenItems first
				parent
		equals: #MyOwnCoolMenu
]

{ #category : #'tests - resolve phase' }
ToMenuBuilderOTest >> testSimpleItemWithMultiplesItemsWithExpliciteDeclaredParent [

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
			(builder itemNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.
	self
		assert:
			(builder itemNamed: #MyOwnCoolMenu) childrenItems second
				label
		equals: 'My own cool tool 2 also here'.
]

{ #category : #'tests - resolve phase' }
ToMenuBuilderOTest >> testSimpleItemWithMultiplesItemsWithNoParentDeclared [

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
			(builder itemNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.
	self
		assert:
			(builder itemNamed: #MyOwnCoolMenu) childrenItems second
				label
		equals: 'My own cool tool 2 also here'.
]

{ #category : #'tests - duplicated items' }
ToMenuBuilderOTest >> testThreeDepth [

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
ToMenuBuilderOTest >> testTwoGroupDeclarationWithSameNameCreatesOnlyOneGroup [

	| g1 |
	(builder item: #Tools) label: 'The root tools'.
	(builder item: #Tools2) label: 'The root tools 2'.
	
	g1 := (builder group: #OurGroup).
	
	"yes parent is a parentName and parent: is part of the public API of the declaration"
	g1 parent: #Tools.

	(builder group: #OurGroup2) parent: #Tools.
	builder resolve.
	
	"for each root"
	self 
		assert: builder collectedItems size 
		equals: 2.
		
	self assert: builder collectedItems first label equals: 'The root tools'.
	self assert: builder collectedItems second label equals: 'The root tools 2'.
	
	self 
		assert: g1 parent 
		equals: #Tools.
	self 
		assert: g1 parentMenuItem name 
		equals: #Tools.	
		
		
		
	
]

{ #category : #'tests - todo' }
ToMenuBuilderOTest >> testTwoGroupsWithSameName [

	(builder group: #Tools) label: 'The root tools'.
	(builder group: #Tools) label: 'The root tools'.

	self 
		assert: builder namesOfAlreadyExistingGroups size 
		equals: 1.
	self assert: (builder namesOfAlreadyExistingGroups includes: #Tools).
]

{ #category : #tests }
ToMenuBuilderOTest >> testWithDeclaresOneItemWithAChild [

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
		assert: (builder itemNamed: #MyMenuChild) parent
		equals: #MyMenu.

	self
		assert: (builder itemNamed: #MyMenuChild) parent
		equals: #MyMenu.

	self
		assert: (builder itemNamed: #MyMenuChild) label
		equals: 'My own cool tool also here'
]

{ #category : #examples }
ToMenuBuilderOTest >> toploExampleMenu [

	^ toploExampleMenu ifNil: [ 
			toploExampleMenu := self toploExampleMenuBuilder: ToMenuBuilderO ]
]

{ #category : #examples }
ToMenuBuilderOTest >> toploExampleMenuBuilder: aBuilderClass [

	"the class ToMenuBuilder defines one method with such pragma for tests."
	
	^ (aBuilderClass pragmaKeyword: #toploWorldMenuXXX123)
		  collectDeclarations;
		  resolve;
		  yourself
]

{ #category : #'world menu' }
ToMenuBuilderOTest >> worldMenuExampleExampleMenu [

	^ worldMenuExample ifNil: [
		  worldMenuExample := self worldMenuExampleMenuBuilder: ToMenuBuilderO ]
]

{ #category : #'world menu' }
ToMenuBuilderOTest >> worldMenuExampleMenuBuilder: aClass [

	^ (aClass pragmaKeyword: #worldMenu)
		  collectDeclarations;
		  resolve;
		  yourself
]
