Class {
	#name : 'ToInfiniteTest',
	#superclass : 'ToParameterizedHostTest',
	#category : 'Toplo-Widget-List-Tests-Core',
	#package : 'Toplo-Widget-List-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToInfiniteTest >> listWithRemoveRowButtons [

	|  list |
	list := self newList.
	list nodeBuilder: [ :node :holder |
		| line remBut filler |
		line := ToPane horizontal id: #row.
		remBut := ToButton new id: #'remove-button-', holder position asString.
		remBut withoutSkin.
		remBut icon: (ToImage inner: (self iconNamed: #windowClose)).
		remBut constraintsDo: [ :c | c linear vertical alignCenter ].
		remBut
			when: BlClickEvent
			do: [ :event |
			event consumed: true.
			holder infiniteElement data removeAt: holder position ].
		filler := ToElement new matchParent; id: #filler.
		line addChild: filler.
		line addChild: remBut.
		node addChild: line ].
	^ list



]

{ #category : 'tests' }
ToInfiniteTest >> newList [

	^ self subclassResponsibility 
	
]

{ #category : 'accessing' }
ToInfiniteTest >> statesOfAmerica [

	^ { #Alabama. #Alaska. #Arizona. #Arkansas. #California. #Colorado.
		#Connecticut. #Delaware. #Florida. #Georgia. #Hawaii. #Idaho. #'Illinois Indiana'.
		#Iowa. #Kansas. #Kentucky. #Louisiana. #Maine. #Maryland. #Massachusetts.
		#Michigan. #Minnesota. #Mississippi. #Missouri. #Montana. #Nebraska.
		#Nevada. #'New Hampshire'. #'New Jersey'. #'New Mexico'.
		#'New York'. #'North Carolina'. #'North Dakota'. #Ohio. #Oklahoma.
		#Oregon. #'Pennsylvania Rhode Island'. #'South Carolina'.
		#'South Dakota'. #Tennessee. #Texas. #Utah. #Vermont. #Virginia.
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }.
]
