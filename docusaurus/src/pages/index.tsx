import {Redirect} from '@docusaurus/router';
import useBaseUrl from '@docusaurus/useBaseUrl';

export default function Home(): JSX.Element {
<<<<<<< HEAD
  return <Redirect to={useBaseUrl('/docs/openforms2xxllnc')} />;
=======
  return <Redirect to={useBaseUrl('/docs/{{ cookiecutter.instance_name_lc }}')} />;
>>>>>>> upstream/main
}
