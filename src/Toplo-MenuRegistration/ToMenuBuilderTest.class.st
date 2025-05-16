Class {
	#name : #ToMenuBuilderTest,
	#superclass : #TestCase,
	#category : #'Toplo-MenuRegistration'
}

{ #category : #tests }
ToMenuBuilderTest >> testBuilderCreationAPI [

	| b |
	b := ToPragmaMenuBuilder
				pragmaKeywords: { #toploWorldMenuExample } model: nil.
	self assert: b menuSpec items size equals: 5
]

{ #category : #tests }
ToMenuBuilderTest >> testBuilderHasItems [

	| b |
	b := ToPragmaMenuBuilder
		     pragmaKeyword: #toploWorldMenuExample
		     model: nil.
	self assert: b menuSpec items size equals: 5
]

{ #category : #tests }
ToMenuBuilderTest >> testBuilderPragmas [

	| b |
	b := ToPragmaMenuBuilder
		     pragmaKeywords: { #toploWorldMenuExample. }
		     model: nil.
	self assert: b pragmas size equals: 5
]

{ #category : #tests }
ToMenuBuilderTest >> testBuilderPragmasWhenPragmaDoesntExist [

	| b |
	b := ToPragmaMenuBuilder pragmaKeyword: #sdfghjgfdsdfghj model: nil.
	self assert: b pragmas size equals: 0.
]

{ #category : #tests }
ToMenuBuilderTest >> testNewBuilder [

	| aBuilder |
	aBuilder := ToMenuRegistration new owner:
		            ToPragmaMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		"place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [
			(aBuilder item: #MyOwnCoolTool)
				label: 'My own cool tool also here';
				target: Smalltalk tools workspace;
				selector: #openContents:;
				arguments:
					#( 'yep, my own cool tool can be also opened from a world sub-menu ! :)' ) ].
	self assert: aBuilder spec
]
