baselines
baseline: spec

	<baseline>
	spec for: #common do: [
			spec
				baseline: 'ContainersEssentials'
				with: [ spec repository: 'github://massimo-nocentini/Containers-Essentials:master' ].

			spec
				baseline: 'ContainersCategory'
				with: [ spec repository: 'github://massimo-nocentini/Containers-Category:master/src' ].

			spec
				package: 'Delimcc'
				with: [ spec requires: #( 'ContainersEssentials' 'ContainersCategory' ) ];
				package: 'Delimcc-Tests'
				with: [ spec requires: #( 'Delimcc' ) ] ]