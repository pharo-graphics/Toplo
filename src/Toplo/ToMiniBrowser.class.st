Class {
	#name : #ToMiniBrowser,
	#superclass : #Object,
	#instVars : [
		'listsPane',
		'mainPane',
		'packages',
		'classes',
		'protocols',
		'selectors',
		'codeModel',
		'codePane'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToMiniBrowser class >> open [
	<script>
	self new open
]

{ #category : #initialization }
ToMiniBrowser >> initialize [ 

	super initialize.
	listsPane := ToHorizontalPane new margin: (BlInsets top: 5).
	listsPane layout: (BlLinearLayout horizontal cellSpacing: 5).
	listsPane matchParent.
	mainPane := ToVerticalPane new.
	mainPane matchParent.
	
	packages := ToList new nodeFactory: [ :pkg | 
		            ToLabeledNode new
			            labelText: pkg name;
			            hMatchParent ].
		
	packages list addAll:
		(RPackage organizer packages asSortedCollection: [ :p1 :p2 | 
			 p1 name < p2 name ]).
		
	classes := ToList new nodeFactory: [ :cls | 
		            ToLabeledNode new
			            labelText: cls name;
			            hMatchParent ].
		
	protocols := ToList new nodeFactory: [ :prot | 
		            ToLabeledNode new
			            labelText: prot name;
			            hMatchParent ].
		
	selectors := ToList new nodeFactory: [ :sel | 
		            ToLabeledNode new
			            labelText: sel asString;
			            hMatchParent ].
	
	codeModel := ToAlbumModel new withRowNumbers.
	codePane := codeModel onWidget. 	
		
	packages withRowNumbers.
	classes withRowNumbers.
	protocols withRowNumbers.
	selectors withRowNumbers.

	listsPane addChild: packages.
	listsPane addChild: classes.
	listsPane addChild: protocols.
	listsPane addChild: selectors.
	
	mainPane addChild: listsPane.
	mainPane addChild: codePane.

]

{ #category : #'instance creation' }
ToMiniBrowser >> open [

	mainPane openInOBlSpace title: 'Mini browser'
]
