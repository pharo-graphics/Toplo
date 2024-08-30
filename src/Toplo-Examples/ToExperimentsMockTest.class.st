Class {
	#name : #ToExperimentsMockTest,
	#superclass : #TestCase,
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #tests }
ToExperimentsMockTest >> testMocks [

	| selectors errors |
	errors := OrderedCollection new.
	selectors := ToExperiments class selectors select: [ :each | each beginsWith: 'example' ].
	self assert: selectors isNotEmpty.  
		
	selectors do: [ :each | [(ToExperiments perform: each ) ] 
							on: Error 
							do: [ :err | errors add: each  ]  ].
						
	BlSpace allInstances do: [ :each | each close ].
	self assert: errors isEmpty.
]
