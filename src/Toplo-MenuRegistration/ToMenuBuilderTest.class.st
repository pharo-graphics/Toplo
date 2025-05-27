Class {
	#name : #ToMenuBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'xmenu',
		'tmenu'
	],
	#category : #'Toplo-MenuRegistration-clean'
}

{ #category : #differential }
ToMenuBuilderTest >> menuBuilder: aClass [

	^ (aClass pragmaKeyword: #toploWorldMenuExample model: self)
		  collectRegistrations;
		  menuSpec;
		  yourself
]

{ #category : #'tests - target/action' }
ToMenuBuilderTest >> testActionSpecifiedAsBlock [

	| aBuilder nestedItem |
	aBuilder :=  ToPragmaCleanMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		"place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [
			(aBuilder item: #MyOwnCoolTool)
				label: 'My own cool tool also here';
				action: [ 'aString' ] ].

	nestedItem := aBuilder itemNamed: #MyOwnCoolTool.
	self assert: nestedItem action class equals: MessageSend.
	
	self 
		assert: (RBParser parseExpression: nestedItem target asString ) statements first 
		equals: (RBParser parseExpression: '[''aString'']') statements first.
	self assert: nestedItem selector equals:  #cull:.
	self assert: nestedItem arguments equals: { aBuilder model }
]

{ #category : #'simple tests' }
ToMenuBuilderTest >> testBuilderPragmas [

	| b |
	b := ToPragmaCleanMenuBuilder
		     pragmaKeywords: { #toploWorldMenuExample }
		     model: nil.
	self assert: b pragmas size equals: 5
]

{ #category : #'simple tests' }
ToMenuBuilderTest >> testBuilderPragmasWhenPragmaDoesntExist [

	| b |
	b := ToPragmaCleanMenuBuilder pragmaKeyword: #sdfghjgfdsdfghj model: nil.
	self assert: b pragmas size equals: 0
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildOrder [

	| xTools |
	xTools := self xmenu itemNamed: #Tools.
	self halt.
	self assert: xTools order equals: 70.
	self assert: xTools order equals: (self tmenu itemNamed: #Tools) order
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildRootIsRoot [

	| xPharo |
	xPharo := self xmenu itemNamed: #Pharo.
	self assert: xPharo owner isGroup.
	self
		assert: xPharo owner isGroup
		equals: (self tmenu itemNamed: #Pharo) owner isGroup
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildRootItemListSize [

	| xPharo |
	xPharo := self xmenu itemNamed: #Pharo.
	self assert: xPharo owner itemList size equals: 12.
	self
		assert: xPharo owner itemList size
		equals: (self tmenu itemNamed: #Pharo) owner itemList size
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildRootPragmaKeyword [

	| xPharo |
	xPharo := self xmenu itemNamed: #Pharo.
	self assert: xPharo owner pragmaKeywords size equals: 1.
	self
		assert: xPharo owner pragmaKeywords size
		equals: (self tmenu itemNamed: #Pharo) owner pragmaKeywords size
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildRootPragmaKeywordSize [

	| xPharo |
	xPharo := self xmenu itemNamed: #Pharo.
	self assert: xPharo owner pragmaKeywords size equals: 1.
	self
		assert: xPharo owner pragmaKeywords size
		equals: (self tmenu itemNamed: #Pharo) owner pragmaKeywords size
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemChildNamed [

	| xSettings |
	xSettings := (self xmenu itemNamed: #Pharo) itemNamed: #Settings.
	self assert: xSettings name equals: #Settings.
	self
		assert: xSettings name
		equals: ((self tmenu itemNamed: #Pharo) itemNamed: #Settings) name
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemChildSize [

	| xPharo |
	xPharo := self xmenu itemNamed: #Pharo.
	self assert: xPharo itemList size equals: 3.
	self
		assert: xPharo itemList size
		equals: (self tmenu itemNamed: #Pharo) itemList size
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemHelpText [

	| xSettings tSettings |
	tSettings := (self tmenu itemNamed: #Pharo) itemNamed: #Settings.
	xSettings := (self xmenu itemNamed: #Pharo) itemNamed: #Settings.
	self assert: xSettings keyText equals: 'o, s'.
	self
		assert: xSettings keyText
		equals: ((self tmenu itemNamed: #Pharo) itemNamed: #Settings) keyText
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemListSize [

	self assert: self xmenu itemList size equals: 12.
	self assert: self xmenu itemList size equals: self tmenu itemList size
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemNamed [

	| xSettings |
	xSettings := self xmenu itemNamed: #Settings.
	self assert: xSettings name equals: #Settings.
	self assert: xSettings name equals: (self tmenu itemNamed: #Settings) name
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemShortCut [

	| xSettings |
	xSettings := (self xmenu itemNamed: #Pharo) itemNamed: #Settings.
	self assert: xSettings name equals: #Settings.
	self
		assert: xSettings name
		equals: ((self tmenu itemNamed: #Pharo) itemNamed: #Settings) name
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffRootIsGroup [

	self assert: self xmenu isGroup.
	self assert: self xmenu isGroup equals: self tmenu isGroup
]

{ #category : #'unification skipped' }
ToMenuBuilderTest >> testDuplicateDeclarationsShouldBeUnified [

	| aBuilder |
	self skip.
	aBuilder := ToPragmaCleanMenuBuilder new.

		((aBuilder item: #Pharo) with: [ aBuilder item: #toto ]).

		((aBuilder item: #Pharo) with: [ aBuilder item: #toto2 ]).

	aBuilder menuSpec.
	self assert: (aBuilder itemNamed: #Pharo) itemList size equals: 2
]

{ #category : #'unification skipped' }
ToMenuBuilderTest >> testDuplicateDeclarationsWithExplicitParentShouldBeUnified [

	| aBuilder |
	self skip.
	aBuilder := ToPragmaCleanMenuBuilder new.

	aBuilder interpretRegistration: ((aBuilder item: #Pharo) with: [
			 (aBuilder item: #toto) parent: #Pharo ]).

	aBuilder interpretRegistration: ((aBuilder item: #Pharo) with: [
			 (aBuilder item: #toto2) parent: #Pharo ]).

	1 halt.
	aBuilder menuSpec.
	self assert: (aBuilder itemNamed: #Pharo) itemList size equals: 2
]

{ #category : #differential }
ToMenuBuilderTest >> testEasy [

	| tSettings |
	tSettings := (self tmenu itemNamed: #Pharo) itemNamed: #Settings
]

{ #category : #differential }
ToMenuBuilderTest >> testGroupIsInParent [

	| aBuilder |
	aBuilder := ToPragmaCleanMenuBuilder new.
	(aBuilder item: #Pharo) with: [ aBuilder group: #Saving ].
	
	self assert: aBuilder itemList first itemList size equals: 1
]

{ #category : #differential }
ToMenuBuilderTest >> testGroupIsInParentWhenHavingSeparateDefinitionParentDefinedAfter [

	| aBuilder |
	aBuilder := ToPragmaCleanMenuBuilder new.

	(aBuilder item: #Settings) parent: #Pharo.
	(aBuilder item: #Pharo) with: [ aBuilder group: #Saving ].

	aBuilder menuSpec.

	self assert: (aBuilder itemNamed: #Pharo) itemList size equals: 2
]

{ #category : #differential }
ToMenuBuilderTest >> testGroupIsInParentWhenHavingSeparateDefinitionParentDefinedFirst [

	| aBuilder |
	aBuilder := ToPragmaCleanMenuBuilder new.

	(aBuilder item: #Pharo) with: [ aBuilder group: #Saving ].
	(aBuilder item: #Settings) parent: #Pharo.

	aBuilder menuSpec.
	self assert: (aBuilder itemNamed: #Pharo) itemList size equals: 2
]

{ #category : #'tests - target/action' }
ToMenuBuilderTest >> testNestedItemAsGroup [

	| aBuilder nestedItem |
	self skip. "so far the parent of the nested element is not set with the with: message"
	aBuilder :=  ToPragmaCleanMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(aBuilder item: #MyOwnCoolTool)
				label: 'My own cool tool also here';
				action: [ 'aString' ] ].
	self halt.
	self assert: (aBuilder itemNamed: #MyOwnCoolMenu).
	nestedItem := aBuilder itemNamed: #MyOwnCoolTool.
	self assert: nestedItem parent group
]

{ #category : #differential }
ToMenuBuilderTest >> testNestedItems [

	| aBuilder |
	aBuilder := ToPragmaCleanMenuBuilder new.

	(aBuilder item: #Pharo) with: [
		(aBuilder group: #Saving2) with: [ aBuilder item: #toto ] ].

	(aBuilder item: #Pharo) with: [
		(aBuilder group: #Saving) with: [ aBuilder item: #toto ] ].

	aBuilder menuSpec.

	self assert: (aBuilder itemNamed: #Pharo) itemList size equals: 2
]

{ #category : #'tests - target/action' }
ToMenuBuilderTest >> testTargetSelectorArgumentsAreImplementedAsMessageSend [

	| aBuilder t nestedItem |
	aBuilder := ToPragmaCleanMenuBuilder new.
	t := (aBuilder item: #MyOwnCoolMenuTop)
		parent: #Tools;
		"place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [
			(aBuilder item: #MyOwnCoolToolChild)
				label: 'My own cool tool also here';
				target: Smalltalk tools workspace;
				selector: #openContents:;
				arguments:
					#( 'yep, my own cool tool can be also opened from a world sub-menu ! :)' ) ].
	self assert: t label equals: 'The coolest tool here'.
	
	nestedItem := t itemNamed: #MyOwnCoolToolChild. 
	
	self assert: nestedItem target equals: Smalltalk tools workspace.
	self assert: nestedItem selector equals:  #openContents:.
	self assert: nestedItem arguments equals: #( 'yep, my own cool tool can be also opened from a world sub-menu ! :)' ).
	self assert: nestedItem action class equals: MessageSend.
	
]

{ #category : #running }
ToMenuBuilderTest >> tmenu [

	^ tmenu ifNil: [ tmenu := self menuBuilder: ToPragmaCleanMenuBuilder ]
]

{ #category : #running }
ToMenuBuilderTest >> xmenu [

	^ xmenu ifNil: [ xmenu := self menuBuilder: PragmaMenuBuilder ]
]
